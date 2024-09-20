; 构建循环体

@.str = private unnamed_addr constant [13 x i8] c"Hello World\0A\00", align 1

define i32 @main() {
    %1 = alloca i32, align 4
    store i32 0, i32* %1, align 4
    br label %2

2:
    %3 = load i32, i32* %1, align 4
    %4 = icmp slt i32 %3, 10 ; 判断是否小于10
    br i1 %4, label %5, label %8 ; 如果小于10，跳转到6，否则跳转到7

5:
    %6 = call i32 (ptr, ...) @printf(ptr @.str)
    %7 = add nsw i32 %3, 1
    store i32 %7, i32* %1, align 4
    br label %2 ; 跳转到2，实现for循环

8:
    ret i32 0
}

declare i32 @printf(ptr noundef, ...)