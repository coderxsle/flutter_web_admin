// 页面切换逻辑
document.addEventListener('DOMContentLoaded', function() {
    // 处理标签页切换
    const tabs = document.querySelectorAll('.auth-tab');
    const tabContents = document.querySelectorAll('.tab-content');
    
    if (tabs.length > 0) {
        tabs.forEach(tab => {
            tab.addEventListener('click', () => {
                // 移除所有标签的active类
                tabs.forEach(t => t.classList.remove('active'));
                // 给当前点击的标签添加active类
                tab.classList.add('active');
                
                // 隐藏所有内容
                tabContents.forEach(content => {
                    content.style.display = 'none';
                });
                
                // 显示对应的内容
                const target = tab.getAttribute('data-target');
                document.getElementById(target).style.display = 'block';
            });
        });
    }
    
    // 处理模态框
    const modalTriggers = document.querySelectorAll('[data-toggle="modal"]');
    const modalCloseButtons = document.querySelectorAll('[data-dismiss="modal"]');
    
    modalTriggers.forEach(trigger => {
        trigger.addEventListener('click', () => {
            const targetModal = document.getElementById(trigger.getAttribute('data-target'));
            if (targetModal) {
                targetModal.style.display = 'flex';
            }
        });
    });
    
    modalCloseButtons.forEach(button => {
        button.addEventListener('click', () => {
            const modal = button.closest('.modal-backdrop');
            if (modal) {
                modal.style.display = 'none';
            }
        });
    });
    
    // 点击模态框背景关闭模态框
    const modals = document.querySelectorAll('.modal-backdrop');
    modals.forEach(modal => {
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.style.display = 'none';
            }
        });
    });
    
    // 侧边栏折叠/展开
    const sidebarToggle = document.getElementById('sidebar-toggle');
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', () => {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('collapsed');
            
            const mainContent = document.querySelector('.main-content');
            mainContent.classList.toggle('expanded');
        });
    }
    
    // 表单验证
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', (e) => {
            let isValid = true;
            
            // 获取所有必填字段
            const requiredFields = form.querySelectorAll('[required]');
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    // 添加错误提示
                    const formGroup = field.closest('.form-group');
                    if (formGroup) {
                        const errorMsg = formGroup.querySelector('.error-message') || document.createElement('div');
                        errorMsg.className = 'error-message';
                        errorMsg.textContent = '此字段不能为空';
                        errorMsg.style.color = 'red';
                        errorMsg.style.fontSize = '12px';
                        errorMsg.style.marginTop = '5px';
                        
                        if (!formGroup.querySelector('.error-message')) {
                            formGroup.appendChild(errorMsg);
                        }
                    }
                }
            });
            
            if (!isValid) {
                e.preventDefault();
            }
        });
    });
    
    // 用户管理页面的搜索功能
    const searchInput = document.getElementById('user-search');
    if (searchInput) {
        searchInput.addEventListener('input', () => {
            const searchTerm = searchInput.value.toLowerCase();
            const userRows = document.querySelectorAll('.user-table tbody tr');
            
            userRows.forEach(row => {
                const userName = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
                const userRole = row.querySelector('td:nth-child(3)').textContent.toLowerCase();
                const userStore = row.querySelector('td:nth-child(4)').textContent.toLowerCase();
                
                if (userName.includes(searchTerm) || userRole.includes(searchTerm) || userStore.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    }
    
    // 分页功能
    const paginationItems = document.querySelectorAll('.pagination-item');
    if (paginationItems.length > 0) {
        paginationItems.forEach(item => {
            item.addEventListener('click', () => {
                paginationItems.forEach(i => i.classList.remove('active'));
                item.classList.add('active');
                
                // 这里可以添加实际的分页逻辑
                // 例如：加载对应页的数据
            });
        });
    }
});

// 模拟登录功能
function login(event) {
    event.preventDefault();
    
    const username = document.getElementById('login-username').value;
    const password = document.getElementById('login-password').value;
    
    // 这里应该是实际的登录逻辑，这里只是模拟
    if (username && password) {
        // 模拟成功登录后跳转到主页
        window.location.href = 'dashboard.html';
    } else {
        alert('请输入用户名和密码');
    }
}

// 模拟注册功能
function register(event) {
    event.preventDefault();
    
    const username = document.getElementById('register-username').value;
    const email = document.getElementById('register-email').value;
    const password = document.getElementById('register-password').value;
    const confirmPassword = document.getElementById('register-confirm-password').value;
    
    // 这里应该是实际的注册逻辑，这里只是模拟
    if (username && email && password && confirmPassword) {
        if (password !== confirmPassword) {
            alert('两次输入的密码不一致');
            return;
        }
        
        // 模拟成功注册后跳转到登录页
        alert('注册成功，请登录');
        // 切换到登录标签
        document.querySelector('[data-target="login-tab"]').click();
    } else {
        alert('请填写所有必填字段');
    }
}

// 模拟添加用户功能
function addUser(event) {
    event.preventDefault();
    
    const username = document.getElementById('add-username').value;
    const email = document.getElementById('add-email').value;
    const role = document.getElementById('add-role').value;
    const store = document.getElementById('add-store').value;
    
    if (username && email && role) {
        // 这里应该是实际的添加用户逻辑，这里只是模拟
        alert('用户添加成功');
        
        // 关闭模态框
        document.getElementById('add-user-modal').style.display = 'none';
        
        // 刷新用户列表（这里只是模拟）
        // 实际应用中应该是通过API获取最新的用户列表
    } else {
        alert('请填写所有必填字段');
    }
}

// 模拟编辑用户功能
function editUser(userId) {
    // 这里应该是获取用户信息并填充到表单中
    // 这里只是模拟
    document.getElementById('edit-username').value = '用户' + userId;
    document.getElementById('edit-email').value = 'user' + userId + '@example.com';
    document.getElementById('edit-role').value = '店铺管理员';
    document.getElementById('edit-store').value = '总店';
    
    // 显示编辑用户模态框
    document.getElementById('edit-user-modal').style.display = 'flex';
}

// 模拟保存编辑用户功能
function saveEditUser(event) {
    event.preventDefault();
    
    const username = document.getElementById('edit-username').value;
    const email = document.getElementById('edit-email').value;
    const role = document.getElementById('edit-role').value;
    const store = document.getElementById('edit-store').value;
    
    if (username && email && role) {
        // 这里应该是实际的保存编辑用户逻辑，这里只是模拟
        alert('用户信息更新成功');
        
        // 关闭模态框
        document.getElementById('edit-user-modal').style.display = 'none';
        
        // 刷新用户列表（这里只是模拟）
        // 实际应用中应该是通过API获取最新的用户列表
    } else {
        alert('请填写所有必填字段');
    }
}

// 模拟删除用户功能
function deleteUser(userId) {
    if (confirm('确定要删除此用户吗？此操作不可撤销。')) {
        // 这里应该是实际的删除用户逻辑，这里只是模拟
        alert('用户已删除');
        
        // 刷新用户列表（这里只是模拟）
        // 实际应用中应该是通过API获取最新的用户列表
    }
} 