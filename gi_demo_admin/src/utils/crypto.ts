import http from './http'

let publicKeyPem: string | null = null
let cachedCryptoKey: CryptoKey | null = null

/**
 * 将 PEM 公钥字符串解析为二进制（Base64 解码）
 * 支持标准 SPKI 格式（BEGIN PUBLIC KEY）
 */
function pemToBinary(pem: string): Uint8Array {
  const b64 = pem
    .replace(/-----BEGIN PUBLIC KEY-----/g, '')
    .replace(/-----END PUBLIC KEY-----/g, '')
    .replace(/\s/g, '')
  if (!b64) {
    throw new Error('无效的 PEM 公钥格式')
  }
  const binary = atob(b64)
  const bytes = new Uint8Array(binary.length)
  for (let i = 0; i < binary.length; i++) {
    bytes[i] = binary.charCodeAt(i)
  }
  return bytes
}

/**
 * 将 ArrayBuffer 转为 Base64 字符串（兼容大 buffer）
 */
function arrayBufferToBase64(buffer: ArrayBuffer): string {
  const bytes = new Uint8Array(buffer)
  const chunkSize = 8192
  let binary = ''
  for (let i = 0; i < bytes.length; i += chunkSize) {
    binary += String.fromCharCode(...bytes.subarray(i, i + chunkSize))
  }
  return btoa(binary)
}

/**
 * 获取公钥（PEM 字符串）
 */
export async function getPublicKey(): Promise<string> {
  if (publicKeyPem) return publicKeyPem

  try {
    const response = await http.post<string>('/auth/publicKey')
    publicKeyPem = response.data
    return publicKeyPem
  } catch (error) {
    console.error('获取公钥失败:', error)
    throw new Error('获取公钥失败')
  }
}

/**
 * 将 PEM 公钥导入为 Web Crypto API 的 CryptoKey（RSA-OAEP）
 */
async function importPublicKey(pem: string): Promise<CryptoKey> {
  if (cachedCryptoKey) return cachedCryptoKey

  const binary = pemToBinary(pem)
  const key = await crypto.subtle.importKey(
    'spki',
    binary.buffer as ArrayBuffer,
    {
      name: 'RSA-OAEP',
      hash: 'SHA-256' // 与后端一致
    },
    true,
    ['encrypt']
  )
  cachedCryptoKey = key
  return key
}

/**
 * 使用 RSA-OAEP（SHA-256）加密密码
 * 与后端 OAEP 要求一致，返回 Base64 密文
 */
export async function encryptPassword(password: string): Promise<string> {
  try {
    const pem = await getPublicKey()
    const key = await importPublicKey(pem)

    const encoded = new TextEncoder().encode(password)
    const encrypted = await crypto.subtle.encrypt(
      {
        name: 'RSA-OAEP'
      },
      key,
      encoded
    )

    return arrayBufferToBase64(encrypted)
  } catch (error) {
    console.error('密码加密失败:', error)
    throw new Error('密码加密失败')
  }
}
