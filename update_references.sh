#!/bin/bash

# 更新引用
update_references() {
  local pattern="$1"
  local replacement="$2"
  local target_dirs=("TOSClientKit/Classes")
  
  for dir in "${target_dirs[@]}"; do
    echo "Updating references in $dir..."
    
    # .h和.m文件中的类引用
    find "$dir" -name "*.h" -o -name "*.m" | xargs grep -l "\b$pattern[A-Za-z0-9_]*" | while read file; do
      echo "Processing $file..."
      # 更新类名
      sed -i '' "s/\([^A-Za-z0-9_]\)$pattern\([A-Za-z0-9_]\+\)/\1$replacement\2/g" "$file"
      # 更新#import语句
      sed -i '' "s/#import [<\"]$pattern/#import [<\"]$replacement/g" "$file"
    done
  done
}

# 执行更新
update_references "YY" "TIMYY"

echo "Reference updates completed!" 