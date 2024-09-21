; C的特性：结构体
; 创建一个结构体，分配内存，存储并读取结构体成员的值

%struct.test = type { i32, i32 }

@.str = private unnamed_addr constant [30 x i8] c"First i32: %d\0ASecond i32: %d\0A\00"
define i32 @main() {
  %1 = alloca i32, align 4
  %2 = alloca %struct.test, align 4 ; 分配一个结构体的内存
  store i32 0, i32* %1, align 4
  ; 计算结构体成员的地址并存储值
  %3 = getelementptr inbounds %struct.test, %struct.test* %2, i32 0, i32 0
  store i32 10, i32* %3, align 4
  %4 = getelementptr inbounds %struct.test, %struct.test* %2, i32 0, i32 1
  store i32 20, i32* %4, align 4

  %val1 = load i32, i32* %3, align 4
  %val2 = load i32, i32* %4, align 4
  ; 打印结构体成员的值
  %5 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 %val1, i32 %val2)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...)