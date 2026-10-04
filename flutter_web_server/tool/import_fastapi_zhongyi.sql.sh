#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${1:-/Users/coderxslee/workspace/FastapiAdmin/backend/sql/postgres/10月3日备份.sql}"
TARGET="${2:-$SCRIPT_DIR/generated/zhongyi_fastapi_import.sql}"

mkdir -p "$(dirname "$TARGET")"

SOURCE="$SOURCE" TARGET="$TARGET" python3 - <<'PY'
from pathlib import Path
import os
import re

source = Path(os.environ["SOURCE"])
target = Path(os.environ["TARGET"])
tables = {
    "zhongyi_patient",
    "zhongyi_medicine_price",
    "zhongyi_medicine_inventory",
    "zhongyi_medicine",
    "zhongyi_inventory_transaction",
    "zhongyi_department",
    "zhongyi_cabinet",
    "zhongyi_bill_item",
    "zhongyi_bill",
    "zhongyi_prescription_template",
    "zhongyi_prescription_template_item",
}

# 源库 status 为 0:正常 1:禁用，目标库为 0:停用 1:启用，必须取反。
# zhongyi_bill 的 active/cancelled 同样归一到 1/0；目标列现在全部是 int，不再带引号。
status_tables = {
    "zhongyi_medicine",
    "zhongyi_medicine_inventory",
    "zhongyi_cabinet",
    "zhongyi_bill_item",
    "zhongyi_bill",
}

columns = {
    "zhongyi_patient": ("id", "tenantId", "name", "gender", "birthDate", "phone", "idCard", "address", "occupation", "bloodType", "emergencyContact", "emergencyPhone", "allergyHistory", "medicalHistory", "familyHistory", "constitution", "source", "deleted", "creator", "createTime", "updater", "updateTime"),
    "zhongyi_medicine_price": ("id", "medicineId", "priceType", "unit", "salePrice", "effectiveFrom", "effectiveTo", "deleted", "creator", "createTime", "updater", "updateTime"),
    "zhongyi_medicine_inventory": ("id", "medicineId", "batchNumber", "supplierId", "quantityG", "unit", "purchasePrice", "productionDate", "expiryDate", "qualityStatus", "storageLocation", "isExhausted", "description", "status", "deleted", "creator", "createTime", "updater", "updateTime"),
    "zhongyi_medicine": ("id", "tenantId", "medicineCode", "prefix", "name", "pinyin", "category", "subcategory", "originPlace", "propertiesJson", "functions", "indications", "commonDosageMin", "commonDosageMax", "dosageWarning", "toxicity", "pregnancyCategory", "isSpecialManagement", "storageRequirements", "shelfLifeMonths", "description", "status", "deleted", "creator", "createTime", "updater", "updateTime"),
    "zhongyi_inventory_transaction": ("id", "tenantId", "medicineId", "inventoryId", "batchNumber", "transactionType", "quantityChangeG", "quantityBeforeG", "quantityAfterG", "remark", "operatorId", "deleted", "creator", "createTime", "updater", "updateTime"),
    "zhongyi_department": ("id", "tenantId", "name", "code", "parentId", "sortOrder", "isActive", "phone", "description", "deleted", "creator", "createTime", "updater", "updateTime"),
    "zhongyi_cabinet": ("id", "cabinetNo", "name", "location", "cabinetType", "medicineId", "capacityG", "isLocked", "description", "status", "deleted", "creator", "createTime", "updater", "updateTime"),
    "zhongyi_bill_item": ("id", "billId", "itemType", "referenceType", "referenceId", "itemName", "specification", "unit", "quantity", "unitPrice", "totalPrice", "isRefunded", "refundedQuantity", "description", "status", "deleted", "creator", "createTime", "updater", "updateTime"),
    "zhongyi_bill": ("id", "billNo", "patientId", "registrationId", "medicalRecordId", "billingStage", "totalAmount", "paidAmount", "refundedAmount", "discountAmount", "discountReason", "paymentStatus", "status", "cashierId", "paidAt", "notes", "description", "deleted", "creator", "createTime", "updater", "updateTime"),
    "zhongyi_prescription_template": ("id", "tenantId", "name", "scope", "category", "sourceType", "sourceId", "doctorId", "syndrome", "efficacy", "doses", "itemsJson", "dailyFrequency", "administrationMethod", "decoctionInstruction", "dietRestrictions", "notes", "isActive", "deleted", "creator", "createTime", "updater", "updateTime"),
    "zhongyi_prescription_template_item": ("id", "templateId", "medicineId", "sortOrder", "role", "dosageGrams", "dosageUnit", "dosageText", "usageMethod", "isSubstitute", "substituteForId", "notes", "deleted", "creator", "createTime", "updater", "updateTime"),
}

def split_values(raw):
    values, start, quote, depth = [], 0, None, 0
    for i, char in enumerate(raw):
        if quote:
            if char == quote and (i == 0 or raw[i - 1] != "\\"):
                quote = None
        elif char in "'\"":
            quote = char
        elif char == "(":
            depth += 1
        elif char == ")":
            depth -= 1
        elif char == "," and depth == 0:
            values.append(raw[start:i].strip())
            start = i + 1
    values.append(raw[start:].strip())
    return values

def value(expr, table, source_col):
    expr = expr.replace("::regclass", "").strip()
    if expr.lower() in {"'t'", "'true'"}:
        return "true"
    if expr.lower() in {"'f'", "'false'"}:
        return "false"
    if expr.upper() == "NULL":
        return "NULL"
    if source_col in {"is_deleted"}:
        return "true" if expr.lower() in {"'t'", "'true'"} else "false"
    if source_col in {"created_id", "updated_id"}:
        return "NULL" if expr == "NULL" else expr
    if source_col in {"created_time", "updated_time", "birth_date", "effective_from", "effective_to", "production_date", "expiry_date", "paid_at"}:
        return expr
    return expr

def text_value(expr):
    if expr.upper() == "NULL":
        return "NULL"
    if len(expr) >= 2 and expr[0] == "'" and expr[-1] == "'":
        return expr
    return "'" + expr.replace("'", "''") + "'"

def status_value(expr):
    if expr.upper() == "NULL":
        return "NULL"
    return "1" if expr.strip("'").strip().lower() in {"active", "enabled", "normal", "0", "true"} else "0"

def patient_gender_value(expr):
    if expr.upper() == "NULL":
        return "3"
    normalized = expr.strip("'").strip().lower()
    if normalized in {"1", "male"}:
        return "1"
    if normalized in {"2", "female"}:
        return "2"
    if normalized in {"3", "other", "secret"}:
        return "3"
    return "3"

def parse_insert(line):
    match = re.match(r'INSERT INTO "public"\."([^"]+)" \((.*?)\) VALUES \((.*)\);$', line)
    if not match or match.group(1) not in tables:
        return None
    table, source_columns, raw_values = match.groups()
    source_columns = [c.strip('" ') for c in source_columns.split('", "')]
    values = split_values(raw_values)
    source = dict(zip(source_columns, values))
    mapping = {
        "id_card": "idCard", "birth_date": "birthDate", "created_time": "createTime",
        "updated_time": "updateTime", "created_id": "creator", "updated_id": "updater",
        "is_deleted": "deleted", "medicine_id": "medicineId", "supplier_id": "supplierId",
        "blood_type": "bloodType", "emergency_contact": "emergencyContact",
        "emergency_phone": "emergencyPhone", "allergy_history": "allergyHistory",
        "medical_history": "medicalHistory", "family_history": "familyHistory",
        "batch_number": "batchNumber", "quantity_g": "quantityG", "purchase_price": "purchasePrice",
        "production_date": "productionDate", "expiry_date": "expiryDate", "quality_status": "qualityStatus",
        "storage_location": "storageLocation", "is_exhausted": "isExhausted", "cabinet_no": "cabinetNo",
        "cabinet_type": "cabinetType", "medicine_code": "medicineCode", "origin_place": "originPlace", "properties": "propertiesJson", "common_dosage_min": "commonDosageMin",
        "common_dosage_max": "commonDosageMax", "dosage_warning": "dosageWarning",
        "pregnancy_category": "pregnancyCategory", "is_special_management": "isSpecialManagement",
        "storage_requirements": "storageRequirements", "shelf_life_months": "shelfLifeMonths",
        "price_type": "priceType", "sale_price": "salePrice", "effective_from": "effectiveFrom",
        "effective_to": "effectiveTo", "tenant_id": "tenantId", "parent_id": "parentId",
        "sort_order": "sortOrder", "is_active": "isActive", "bill_no": "billNo",
        "patient_id": "patientId", "registration_id": "registrationId", "medical_record_id": "medicalRecordId",
        "billing_stage": "billingStage", "total_amount": "totalAmount", "paid_amount": "paidAmount",
        "refunded_amount": "refundedAmount", "discount_amount": "discountAmount", "discount_reason": "discountReason",
        "payment_status": "paymentStatus", "cashier_id": "cashierId", "paid_at": "paidAt",
        "bill_id": "billId", "item_type": "itemType", "reference_type": "referenceType",
        "reference_id": "referenceId", "item_name": "itemName", "unit_price": "unitPrice",
        "total_price": "totalPrice", "is_refunded": "isRefunded", "refunded_quantity": "refundedQuantity",
        "operator_id": "operatorId", "transaction_type": "transactionType", "quantity_change": "quantityChangeG",
        "quantity_before": "quantityBeforeG", "quantity_after": "quantityAfterG",
        "source_type": "sourceType", "source_id": "sourceId", "doctor_id": "doctorId",
        "daily_frequency": "dailyFrequency", "administration_method": "administrationMethod",
        "decoction_instruction": "decoctionInstruction", "diet_restrictions": "dietRestrictions",
        "template_id": "templateId", "sort_order": "sortOrder", "dosage_grams": "dosageGrams",
        "dosage_unit": "dosageUnit", "dosage_text": "dosageText", "usage_method": "usageMethod",
        "is_substitute": "isSubstitute", "substitute_for_id": "substituteForId",
    }
    out = {}
    for source_col, expr in source.items():
        target_col = mapping.get(source_col, source_col)
        if target_col in columns[table]:
            if source_col == "status" and table in status_tables:
                out[target_col] = status_value(expr)
            elif table == "zhongyi_patient" and source_col == "gender":
                out[target_col] = patient_gender_value(expr)
            else:
                out[target_col] = text_value(expr) if source_col in {"created_id", "updated_id", "dosage_warning"} else value(expr, table, source_col)
    for source_col, target_col in (("created_id", "creator"), ("updated_id", "updater")):
        if target_col in columns[table] and target_col not in out and source_col in source:
            out[target_col] = text_value(source[source_col])
    if table == "zhongyi_medicine_inventory":
        out.setdefault("description", "NULL")
    if table == "zhongyi_bill":
        out.setdefault("description", "NULL")
    if table == "zhongyi_prescription_template":
        # FastapiAdmin 的旧表没有租户列和 items_json；Serverpod 模型要求这两列。
        out.setdefault("tenantId", "0")
        out.setdefault("itemsJson", "'[]'")
    fields = [c for c in columns[table] if c in out]
    quoted_fields = [chr(34) + c + chr(34) for c in fields]
    updates = ", ".join(f'{field} = EXCLUDED.{field}' for field in quoted_fields if field != '"id"')
    return f'INSERT INTO "{table}" ({", ".join(quoted_fields)}) VALUES ({", ".join(out[c] for c in fields)}) ON CONFLICT ("id") DO UPDATE SET {updates};'

lines = []
for line in source.read_text(encoding="utf-8").splitlines():
    parsed = parse_insert(line)
    if parsed:
        lines.append(parsed)

ordered = []
for table in ("zhongyi_patient", "zhongyi_department", "zhongyi_medicine", "zhongyi_medicine_price", "zhongyi_medicine_inventory", "zhongyi_cabinet", "zhongyi_inventory_transaction", "zhongyi_bill", "zhongyi_bill_item", "zhongyi_prescription_template", "zhongyi_prescription_template_item"):
    ordered.extend(line for line in lines if f'INTO "{table}"' in line)

sequence_tables = (
    "zhongyi_medicine", "zhongyi_medicine_price", "zhongyi_medicine_inventory", "zhongyi_patient",
    "zhongyi_department", "zhongyi_cabinet", "zhongyi_inventory_transaction", "zhongyi_bill",
    "zhongyi_bill_item", "zhongyi_prescription_template", "zhongyi_prescription_template_item",
)
sequence_sql = []
for table in sequence_tables:
    sequence_sql.append(
        f'SELECT setval(\'{table}_id_seq\', COALESCE(MAX("id"), 1), MAX("id") IS NOT NULL) FROM "{table}";'
    )
relation_sql = [
    "UPDATE \"zhongyi_bill\" b SET \"tenantId\" = p.\"tenantId\" FROM \"zhongyi_patient\" p WHERE p.\"id\" = b.\"patientId\";",
    "DO $$ BEGIN",
    "  IF EXISTS (SELECT 1 FROM \"zhongyi_bill\" b LEFT JOIN \"zhongyi_patient\" p ON p.\"id\" = b.\"patientId\" WHERE p.\"id\" IS NULL) THEN",
    "    RAISE EXCEPTION '账单存在不存在的患者记录';",
    "  END IF;",
    "  IF EXISTS (SELECT 1 FROM \"zhongyi_prescription_template_item\" i LEFT JOIN \"zhongyi_prescription_template\" t ON t.\"id\" = i.\"templateId\" WHERE t.\"id\" IS NULL) THEN",
    "    RAISE EXCEPTION '处方模板明细存在不存在的模板主表记录';",
    "  END IF;",
    "  IF EXISTS (SELECT 1 FROM \"zhongyi_prescription_template_item\" i LEFT JOIN \"zhongyi_medicine\" m ON m.\"id\" = i.\"medicineId\" WHERE m.\"id\" IS NULL) THEN",
    "    RAISE EXCEPTION '处方模板明细存在不存在的药品记录';",
    "  END IF;",
    "END $$;",
]
target.write_text(
    "-- Generated from FastapiAdmin PostgreSQL backup. Safe to re-run.\nBEGIN;\n"
    + "\n".join(ordered)
    + "\n"
    + "\n".join(sequence_sql)
    + "\n"
    + "\n".join(relation_sql)
    + "\nCOMMIT;\n",
    encoding="utf-8",
)
print(f"generated {len(ordered)} rows: {target}")
PY
