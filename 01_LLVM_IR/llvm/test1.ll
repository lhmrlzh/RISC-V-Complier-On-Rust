; 打印Hello World

@.str = private unnamed_addr constant [13 x i8] c"Hello World\0A\00"
define i32 @main() {
    %1 = call i32 (ptr, ...) @printf(ptr noundef @.str); 调用printf函数
    ret i32 0
}

declare i32 @printf(ptr noundef, ...)