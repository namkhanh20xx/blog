#!/bin/bash

# Lấy năm và tháng hiện tại
YEAR=$(date +%Y)
MONTH=$(date +%m)
SLUG=$1

# Kiểm tra nếu chưa nhập tên bài viết
if [ -z "$SLUG" ]; then
    echo "Sử dụng: ./new_post.sh ten-bai-viet"
    exit 1
fi

# Chạy lệnh Hugo với đường dẫn tự động
hugo new "posts/$YEAR/$MONTH/$SLUG.md"
