#!/usr/bin/env python3

with open('public/sponsor.html', 'r') as f:
    content = f.read()

# 找到前言部分结束的位置
tip_end = content.find('</div>', content.find('<div class="tip custom-block">'))

# 找到展位赞助和无偿赞助部分
exhibition_start = content.find('<h2 id="展位赞助"', tip_end)
exhibition_end = content.find('<h2 id="无偿赞助"', exhibition_start)
donation_start = exhibition_end
donation_end = content.find('</div>\n                                    </div>\n                                </main>', donation_start)

# 交换两个部分的顺序
new_content = (
    content[:tip_end+6] + '\n' +
    content[donation_start:donation_end] + '\n' +
    content[exhibition_start:exhibition_end] + '\n' +
    content[donation_end:]
)

# 增加内容宽度
new_content = new_content.replace('<div class="content-container" data-v-94da3f6a="">', '<div class="content-container" style="max-width: 900px;" data-v-94da3f6a="">')

with open('public/sponsor.html', 'w') as f:
    f.write(new_content)

print('文件已修改完成') 