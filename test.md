计算机基础
---
* 将十进制数25转换为二进制和十六进制，分别是多少？

* 在Windows系统中，如何查看本机的IP地址？（至少两种方式）

* 在局域网中有A、B两台电脑，在电脑A可以Ping通电脑B，而电脑B Ping不通电脑A，可能是什么原因？

* C/S架构与B/S架构分别是什么意思，有哪些区别？

* 在Windows系统中，_PATH_ 环境变量的作用是什么？

* 一个C类IP地址网络中，最多可以容纳多少个主机？

数据库
---
* 请列出几种常见的数据库软件。其中你最熟悉的是？

* 在数据库中，有以下的表结构：
    
    学生信息表：_students_
    
    |  _id_  | _name_  |_class_id_|_srore_|_c_date_|
    |--------|---------|----------|------|---------|
    | 学生ID | 学生姓名 |  班级ID  | 成绩 | 创建日期 |
    
    班级信息表：_classes_
    
    |  _id_  |  _name_ |_c_date_|
    |--------|---------|--------|
    | 班级ID | 班级名称 |创建日期|
    
    请写出以下SQL语句：
    
    * 查询"李华"同学的成绩。
    * 查询"四年级1班"班级的平均成绩。
    * 查询"四年级1班"不及格（成绩低于60分）的的同学名单及人数。
    * 查询"四年级2班"的排名前十的同学名单，并按照成绩从高到低排列。
    * 查询"四年级2班"的成绩处于60至79分区间内（含）的同学名单，并按照成绩从高到低排列。
    * 将"李华"同学的成绩设置为90分。
    * 将"李华"同学的成绩提高10分，但是最高不能高过100分。
    * 将"四年级1班"所有学生的成绩设置为空值。
    * 使用两种不同的方式，删除 _classes_ 表中的所有数据。
    * 删除两个表中创建日期早于2016/09/01的数据。
    * 现在需要增加教师信息，包含姓名和联系电话。每个班级可能有多名教师，且每位教师可以同时为多个班级上课。请描述修改思路。<br>
    * 根据修改后的结构，查询"李华"同学的所有任课老师的姓名和联系电话。

软件测试
---
* 结合以往的工作经历，描述一下软件缺陷（BUG）的管理流程？提交软件缺陷记录时需要注意哪些内容？

* 有一个程序可以判断以三个数字是否能够构成一个三角形。程序输入三个数字，返回是或否。
    <br>
    现在需要对该程序进行测试，检测它是否符合设计要求。请描述大致思路及如何设计测试用例。

* 有一个程序可以判断一个密码是否符合特定格式。程序输入密码的字符串，返回是或否。 密码的格式如下：
    * 长度为6至15位（含）
    * 必须同时含有大写英文字符、小写英文字符、数字
    * 可以含有下划线，但是不可以作为第一个字符
    * 不允许其它的字符出现
    
    现在需要对该程序进行测试，检测它是否符合设计要求。请描述大致思路及如何设计测试用例。
    
简单编程题
---
* 使用任意一门你熟悉的编程语言，输出100以内的所有质数。

* 使用任意一门你熟悉的编程语言，计算 1/2 + 1/3 + ... + 1/99 的值。

* 使用任意一门你熟悉的编程语言，输入三个整数，判断是否能分别以它们为边长构成一个三角形。

* 使用任意一门你熟悉的编程语言，判断一个字符串是否符合IP地址的格式（IPv4）。

* 使用任意一门你熟悉的编程语言，判断一个由"("、")"、"["、"]"两种括号组成的字符串的括号是否闭合。
    
    如"([])[]"是闭合的的，而"(((("或"[(])"是不闭合的。

数学基础
---
* 用'0'至'5'五个数字，可以组合出多少个各不相同的五位数？（0不作为首位，数字可重复出现）

* 6个人分乘两辆不同的汽车，每辆车最多坐4人，有多少种不同的乘车组合方式？

* 有36辆赛车，6条跑道，在没有计时器的情况下，进行多少次比赛，可以确定最快的前三名？