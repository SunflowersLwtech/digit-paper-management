/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 90200 (9.2.0)
 Source Host           : localhost:3306
 Source Schema         : e_paper

 Target Server Type    : MySQL
 Target Server Version : 90200 (9.2.0)
 File Encoding         : 65001

 Date: 29/04/2025 16:54:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `image` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '头像',
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '密码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='管理员表';

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` (`id`, `image`, `username`, `password`, `create_time`) VALUES (1, NULL, 'admin', 'admin', '2025-03-12 22:53:12');
COMMIT;

-- ----------------------------
-- Table structure for classes
-- ----------------------------
DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '班级名称',
  `remark` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '描述',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='班级表';

-- ----------------------------
-- Records of classes
-- ----------------------------
BEGIN;
INSERT INTO `classes` (`id`, `name`, `remark`, `create_time`) VALUES (1, '23级软件工程1班', '23级软件工程1班', '2025-03-12 22:55:59');
INSERT INTO `classes` (`id`, `name`, `remark`, `create_time`) VALUES (2, '23级软件工程2班', '23级软件工程2班', '2025-03-15 12:54:34');
INSERT INTO `classes` (`id`, `name`, `remark`, `create_time`) VALUES (3, '23级软件工程3班', '23级软件工程3班', '2025-03-15 12:54:50');
INSERT INTO `classes` (`id`, `name`, `remark`, `create_time`) VALUES (4, '23级计算机科学与技术1班', '23级计算机科学与技术1班', '2025-03-15 12:55:12');
INSERT INTO `classes` (`id`, `name`, `remark`, `create_time`) VALUES (5, '23级计算机科学与技术2班', '23级计算机科学与技术2班', '2025-03-15 12:55:26');
INSERT INTO `classes` (`id`, `name`, `remark`, `create_time`) VALUES (6, '23级计算机科学与技术3班', '23级计算机科学与技术3班', '2025-03-15 12:55:45');
COMMIT;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `mid` int DEFAULT NULL COMMENT '专业',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '课程名称',
  `remark` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '课程描述',
  `status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='课程表';

-- ----------------------------
-- Records of course
-- ----------------------------
BEGIN;
INSERT INTO `course` (`id`, `mid`, `name`, `remark`, `status`, `create_time`) VALUES (3, 1, 'Java语言程序设计', 'Java语言程序设计', '01', '2025-03-15 13:00:45');
INSERT INTO `course` (`id`, `mid`, `name`, `remark`, `status`, `create_time`) VALUES (4, 1, 'Python语言程序设计', 'Python语言程序设计', '01', '2025-03-15 13:01:22');
INSERT INTO `course` (`id`, `mid`, `name`, `remark`, `status`, `create_time`) VALUES (5, 2, '离散数学', '离散数学', '01', '2025-03-15 13:01:46');
INSERT INTO `course` (`id`, `mid`, `name`, `remark`, `status`, `create_time`) VALUES (6, 2, '数据库原理', '数据库原理', '01', '2025-03-15 13:01:48');
INSERT INTO `course` (`id`, `mid`, `name`, `remark`, `status`, `create_time`) VALUES (7, 2, 'Java语言程序设计', 'Java语言程序设计', '01', '2025-03-15 13:01:51');
INSERT INTO `course` (`id`, `mid`, `name`, `remark`, `status`, `create_time`) VALUES (8, 2, 'Python语言程序设计', 'Python语言程序设计', '01', '2025-03-15 13:01:57');
INSERT INTO `course` (`id`, `mid`, `name`, `remark`, `status`, `create_time`) VALUES (9, 3, '高等数学', '高等数学', '01', '2025-03-15 13:02:00');
INSERT INTO `course` (`id`, `mid`, `name`, `remark`, `status`, `create_time`) VALUES (10, 3, '线性代数', '线性代数', '01', '2025-03-15 13:02:03');
INSERT INTO `course` (`id`, `mid`, `name`, `remark`, `status`, `create_time`) VALUES (1001, 1001, 'test', 'test', '01', '2025-04-25 20:07:02');
COMMIT;

-- ----------------------------
-- Table structure for exams
-- ----------------------------
DROP TABLE IF EXISTS `exams`;
CREATE TABLE `exams` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '试卷标题',
  `cid` int DEFAULT NULL COMMENT '所属课程',
  `ccid` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '所属班级',
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '试卷类型',
  `file_path` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '文件路径',
  `file_type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '文件类型',
  `status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='试卷表';

-- ----------------------------
-- Records of exams
-- ----------------------------
BEGIN;
INSERT INTO `exams` (`id`, `title`, `cid`, `ccid`, `type`, `file_path`, `file_type`, `status`, `create_time`) VALUES (105, '2025计算机科学与技术Java期末考试', 7, '4,5,6', '01', '79f41165-de35-488d-9cdc-27ab5e97d5e0.pdf', 'pdf', '01', '2025-03-17 13:33:25');
INSERT INTO `exams` (`id`, `title`, `cid`, `ccid`, `type`, `file_path`, `file_type`, `status`, `create_time`) VALUES (106, 'Java期末考试', 7, '3,2,1', '02', '/api/upload/20250317133952.jpeg', 'jpeg', '01', '2025-03-17 13:39:54');
INSERT INTO `exams` (`id`, `title`, `cid`, `ccid`, `type`, `file_path`, `file_type`, `status`, `create_time`) VALUES (113, 'java期末考试', 3, '2,3,1', '02', '/api/upload/20250424121743.png', 'png', '01', '2025-04-24 12:17:47');
INSERT INTO `exams` (`id`, `title`, `cid`, `ccid`, `type`, `file_path`, `file_type`, `status`, `create_time`) VALUES (114, 'python考试', 4, '3,2', '01', '877bb4bf-5a22-475e-9df8-336def80b24b.pdf', 'pdf', '01', '2025-04-24 12:18:15');
INSERT INTO `exams` (`id`, `title`, `cid`, `ccid`, `type`, `file_path`, `file_type`, `status`, `create_time`) VALUES (123, 'python考试test', 4, '3,2,1', '01', 'd34beabe-9aa9-42d1-8c25-c280be24e7e9.pdf', 'pdf', '01', '2025-04-29 10:20:53');
INSERT INTO `exams` (`id`, `title`, `cid`, `ccid`, `type`, `file_path`, `file_type`, `status`, `create_time`) VALUES (124, 'test', 4, '3,2,1', '01', '571ec78c-4ff0-4925-a529-74914c8e365d.pdf', 'pdf', '01', '2025-04-29 10:23:17');
INSERT INTO `exams` (`id`, `title`, `cid`, `ccid`, `type`, `file_path`, `file_type`, `status`, `create_time`) VALUES (125, '123213', 7, '6', '01', '3c92163d-613d-4f9a-a3e6-0b3d458481fb.pdf', 'pdf', '01', '2025-04-29 16:25:59');
INSERT INTO `exams` (`id`, `title`, `cid`, `ccid`, `type`, `file_path`, `file_type`, `status`, `create_time`) VALUES (126, '12312313', 4, '1,2,3', '01', '13987dce-c804-411f-ae40-34cc54e22440.pdf', 'pdf', '01', '2025-04-29 16:26:33');
COMMIT;

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '专业名称',
  `remark` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '专业介绍',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='专业表';

-- ----------------------------
-- Records of major
-- ----------------------------
BEGIN;
INSERT INTO `major` (`id`, `name`, `remark`, `create_time`) VALUES (1, '软件工程', '软件工程', '2025-03-15 12:56:56');
INSERT INTO `major` (`id`, `name`, `remark`, `create_time`) VALUES (2, '计算机科学与技术', '计算机科学与技术', '2025-03-15 12:57:10');
INSERT INTO `major` (`id`, `name`, `remark`, `create_time`) VALUES (3, '通信工程', '通信工程', '2025-03-15 12:57:56');
INSERT INTO `major` (`id`, `name`, `remark`, `create_time`) VALUES (4, '工商管理', '工商管理', '2025-03-15 12:58:25');
INSERT INTO `major` (`id`, `name`, `remark`, `create_time`) VALUES (5, '市场营销', '市场营销', '2025-03-15 12:58:41');
INSERT INTO `major` (`id`, `name`, `remark`, `create_time`) VALUES (6, '电子商务', '电子商务', '2025-03-15 12:59:01');
INSERT INTO `major` (`id`, `name`, `remark`, `create_time`) VALUES (1001, 'test', 'test', '2025-04-25 20:06:44');
COMMIT;

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '公告标题',
  `content` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '公告内容',
  `status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='公告表';

-- ----------------------------
-- Records of notice
-- ----------------------------
BEGIN;
INSERT INTO `notice` (`id`, `title`, `content`, `status`, `create_time`) VALUES (24, '开学啦', '<p>开学啦，新的一学期如约而至，校园里再次充满了欢声笑语。清晨，阳光洒在操场上，迎着微风，学生们背着书包，迈着轻快的步伐走进校园。熟悉的教室、整齐的课桌、崭新的课本，一切都焕然一新，仿佛在迎接大家的归来。</p><p>久违的同学们彼此问候，分享假期里的趣事，教室里洋溢着热烈的气氛。老师站在讲台上，微笑着欢迎大家回到课堂，讲述着新学期的规划与目标。新的课程、新的挑战、新的成长等待着每一个人。</p><p>操场上，体育课的哨声响起，晨跑的队伍整齐划一，篮球场上跃动着矫健的身影。图书馆里，安静的自习区已经坐满了认真学习的同学，翻阅书籍的沙沙声与窗外的微风交织在一起，构成了一幅美好的画面。</p><p>开学不仅是一个新的起点，更是一次成长的契机。新的学期，新的希望，每个人都带着憧憬与期待，迎接充满挑战和机遇的未来。在这片知识的海洋里，让我们怀揣梦想，勇敢前行，书写属于自己的精彩篇章！</p>', '01', '2025-03-15 13:49:04');
COMMIT;

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cid` int DEFAULT NULL COMMENT '所属课程',
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '题目类型',
  `content` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '题目内容',
  `answer` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '答案',
  `options` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '选项',
  `status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='题目表';

-- ----------------------------
-- Records of question
-- ----------------------------
BEGIN;
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (115, 7, '01', '1．Java application中的主类需包含main方法，以下哪项是main方法的正确形参？（ ）\n', 'B', '{\"A\":\"String args\",\"B\":\"String args[]\",\"C\":\"Char arg \",\"D\":\"StringBuffer args[]\"}', '01', '2025-03-15 13:42:53');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (116, 7, '01', '以下代码段执行后的输出结果为（ ）\nint x=－3； int y=－10；\n', 'A', '{\"A\":\"-1\",\"B\":\"2\",\"C\":\"1\",\"D\":\"3\"}', '01', '2025-03-15 13:45:06');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (117, 7, '01', '以下关于继承的叙述正确的是（ ）', 'A', '{\"A\":\"在Java中类只允许单一继承\",\"B\":\"在Java中一个类只能实现一个接口\",\"C\":\"在Java中一个类不能同时继承一个类和实现一个接口\",\"D\":\"在Java中接口只允许单一继承\"}', '01', '2025-03-15 13:46:02');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (118, 7, '01', '若有定义：byte[] x={11,22,33,-66};\n其中0≤k≤3，则对x数组元素错误的引用是（ ）\n', 'C', '{\"A\":\"x[5-3]\",\"B\":\"x[k]\",\"C\":\"x[k+5]\",\"D\":\"x[0]\"}', '01', '2025-03-15 13:46:44');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (119, 7, '01', '以下哪个不是Java的原始数据类型（ ）', 'B', '{\"A\":\"int\",\"B\":\"Boolean\",\"C\":\"float\",\"D\":\"char\"}', '01', '2025-03-15 13:47:32');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (120, 7, '02', '开发与运行Java程序需要经过的三个主要步骤为________、________和________。', '编辑源程序 编译生成字节码 解释运行字节码', NULL, '01', '2025-03-17 12:43:44');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (121, 7, '02', '在Java的基本数据类型中，char型采用Unicode编码方案，每个Unicode码占用________字节内存空间，这样，无论是中文字符还是英文字符，都是占用________字节内存空间。', '2 2', NULL, '01', '2025-03-17 12:44:58');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (122, 7, '02', '设x=2,则表达式(x++)／3的值是________ 。', '0', NULL, '01', '2025-03-17 12:46:36');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (123, 7, '02', '如果将类MyClass声明为public，它的文件名称必须是_______才能正常编译。', 'MyClass.java', NULL, '01', '2025-03-17 13:25:23');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (124, 7, '02', '异常处理是由_______、_______和finally块三个关键所组成的程序块。', 'try catch', NULL, '01', '2025-03-17 13:27:21');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (125, 7, '03', '简述this关键字的用法.', '1、this调用本类中的属性，也就是类中的成员变量；\n2、this调用本类中的其他方法；\n3、this调用本类中的其他构造方法，调用时要放在构造方法的首行。', NULL, '01', '2025-03-17 13:28:05');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (126, 7, '03', 'java实现多态的机制是什么？', '1.编译多态：主要是体现在重载，系统在编译时就能确定调用重载函数的哪个版本。\n2.运行多态：主要体现在OO设计的继承性上，子类的对象也是父类的对象，即上溯造型，所以子类对象可以作为父类对象使用，父类的对象变量可以指向子类对象。因此通过一个父类发出的方法调用可能执行的是方法在父类中的实现，也可能是某个子类中的实现，它是由运行时刻具体的对象类型决定的。\n靠的是父类或接口定义的引用变量可以指向子类或具体实现类的实例对象，而程序调用的方法在运行期才动态绑定，就是引用变量所指向的具体实例对象的方法，也就是内存里正在运行的那个对象的方法，而不是引用变量的类型中定义的方法。', NULL, '01', '2025-03-17 13:29:01');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (127, 7, '03', '请说出作用域public，private，protected，以及不写时的区别', 'private修饰的成员变量和函数只能在类本身和内部类中被访问。\nprotected 修饰的成员变量和函数能被类本身、子类及同一个包中的类访问。\npublic修饰的成员变量和函数可以被类、子类、同一个包中的类以及任意其他类访问。\n默认情况（不写）下，属于一种包访问，即能被类本身以及同一个包中的类访问。', NULL, '01', '2025-03-17 13:31:51');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (129, 4, '01', '下列哪个语句在Python中是非法的？（）', 'B', '{\"A\":\"x = y = z = 1\",\"B\":\"x = (y = z + 1)\",\"C\":\"x, y = y, x\",\"D\":\"x += y x=x+y\"}', '01', '2025-03-17 13:47:54');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (130, 4, '01', '关于Python内存管理，下列说法错误的是（）', 'B', '{\"A\":\"变量不必事先声明\",\"B\":\"变量无须先创建和赋值而直接使用\",\"C\":\"变量无须指定类型\",\"D\":\"可以使用del释放资源\"}', '01', '2025-03-17 13:50:24');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (131, 4, '01', 'print(100-25*3%4)应该输出什么? ()', 'B', '{\"A\":\"1\",\"B\":\"97\",\"C\":\"25\",\"D\":\"0\"}', '01', '2025-03-17 13:52:08');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (132, 4, '01', '下列哪种说法是错误的（）', 'A', '{\"A\":\"除字典类型外，所有标准对象均可以用于布尔测试\",\"B\":\"空字符串的布尔值是False\",\"C\":\"空列表对象的布尔值是False\",\"D\":\"值为0的任何数字对象的布尔值是False\"}', '01', '2025-03-17 13:54:47');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (133, 4, '01', '以下不能创建一个字典的语句是（）', 'C', '{\"A\":\"dict1 = {} \",\"B\":\"dict2 = { 3 : 5 }\",\"C\":\"dict3 = dict( [2 , 5] ,[ 3 , 4 ] )\",\"D\":\"dict4 = dict( ( [1,2],[3,4] ) )\"}', '01', '2025-03-17 14:01:19');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (134, 4, '02', 'Python中使用_____进行单行注释。', '#', NULL, '01', '2025-03-17 14:12:49');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (135, 4, '02', 'Python中对两个整数进行整除时，使用的符号为______。', '//', NULL, '01', '2025-03-17 14:14:01');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (136, 4, '02', 'Python 中上下文管理器使用的关键字是______。', 'with', NULL, '01', '2025-03-17 14:15:23');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (137, 4, '02', 'Python中使用内嵌的______函数获取对象的类型。', 'type()', NULL, '01', '2025-03-17 14:16:35');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (138, 4, '02', 'Python异常处理时，把可能发生异常的代码放在______语句中。', 'try', NULL, '01', '2025-03-17 14:18:06');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (139, 4, '03', '请描述列表和元组之间的区别，以及分别在他们之间转型？', '不同点：\n1 定义的方式，list[] tuple()\n2 list可变 tuple() 不可变\n3 list中有 append()，insert() 函数，tuple中没有\n相同点：都是有序的集合（容器）\n\nList转为tuple:\ntemp_list = [1,2,3,4,5]\n将temp_list进行强制转换：tuple(temp_list)\n\ntuple 转为list:\ntemp_tuple = (1,2,3)\n方法类似，也是进行强制转换即可：list(temp_tuple)', NULL, '01', '2025-03-17 14:27:05');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (140, 4, '03', '定义函数的规则', '1函数代码块以 def 关键词开头，后接函数标识符名称和圆括号()。\n2任何传入参数和自变量必须放在圆括号中间。圆括号之间可以用于定义参数。\n3函数的第一行语句可以选择性地使用文档字符串一用于存放函数说明。\n4函数内容以冒号起始，并且缩进。\n5 return [表达式] 结束函数，选择性地返回一个值给调用方。不带表达式的return相当于返回 None。', NULL, '01', '2025-03-17 14:37:17');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (141, 4, '03', '__new__和__init__的区别？', '__new__是一个静态方法,而__init__是一个实例方法.\n__new__方法会返回一个创建的实例,而__init__什么都不返回.\n只有在__new__返回一个cls的实例时后面的__init__才能被调用.\n当创建一个新实例时调用__new__,初始化一个实例时用__init__.', NULL, '01', '2025-03-17 14:41:41');
INSERT INTO `question` (`id`, `cid`, `type`, `content`, `answer`, `options`, `status`, `create_time`) VALUES (142, 4, '03', 'read，readline和readlines之间的区别？', 'read读取整个文件 \nreadline读取下一行，使用生成器方法\nreadlines读取整个文件到一个迭代器以供我们遍历', NULL, '01', '2025-03-17 14:53:01');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `image` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '头像',
  `sno` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '学号',
  `cid` int DEFAULT NULL COMMENT '班级',
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '手机号',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '密码',
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '类型',
  `realname` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '姓名',
  `sex` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '性别',
  `age` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '年龄',
  `address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '地址',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (1, '/api/upload/1.jpeg', 'b23015134', 1, '18200000000', '123123xs', '02', '徐硕', '男', '21', '上海市浦东新区博兴路', '2025-03-15 12:49:48');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (2, '/api/upload/10.jpeg', 'b23080825', 3, '1030002731', '123123xs', '02', '罗嘉伦', '男', '22', '中国北京市西城区西長安街924号6栋', '2025-03-11 20:10:38');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (3, '/api/upload/10.jpeg', 'b23059199', 2, '75545468917', '123123xs', '02', '朱杰宏', '男', '22', '中国深圳罗湖区清水河一路751号13栋', '2025-03-08 18:34:08');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (4, '/api/upload/1.jpeg', 'b23073000', 2, '16373499219', '123123xs', '02', '宋嘉伦', '男', '22', '中国东莞东泰五街24号19栋', '2025-03-10 06:39:14');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (5, '/api/upload/10.jpeg', 'b23086095', 2, '7691700438', '123123xs', '02', '江詩涵', '女', '23', '中国东莞坑美十五巷556号41号楼', '2025-03-06 03:31:09');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (6, '/api/upload/10.jpeg', 'b23002075', 5, '200678448', '123123xs', '02', '张嘉伦', '男', '21', '中国广州市海珠区江南西路78号46楼', '2025-03-07 11:58:49');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (7, '/api/upload/9.jpeg', 'b23037712', 6, '7551608659', '123123xs', '02', '杜璐', '女', '22', '中国深圳罗湖区清水河一路184号11室', '2025-03-10 20:44:32');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (8, '/api/upload/10.jpeg', 'b23003318', 2, '2828911781', '123123xs', '02', '孔安琪', '女', '22', '中国成都市锦江区人民南路四段306号38号楼', '2025-03-07 15:45:08');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (9, '/api/upload/7.jpeg', 'b23051366', 3, '13515335214', '123123xs', '02', '方晓明', '男', '22', '中国中山乐丰六路931号15号楼', '2025-03-12 08:13:56');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (10, '/api/upload/10.jpeg', 'b23088078', 4, '2174512495', '123123xs', '02', '卢秀英', '女', '21', '中国上海市浦东新区健祥路887号27号楼', '2025-03-09 20:14:59');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (11, '/api/upload/9.jpeg', 'b23007648', 4, '13154609489', '123123xs', '02', '杨嘉伦', '男', '22', '中国北京市延庆区028县道804号32号楼', '2025-03-05 06:45:08');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (12, '/api/upload/2.jpeg', 'b23076655', 5, '17976920854', '123123xs', '02', '许云熙', '男', '23', '中国上海市浦东新区橄榄路292号42栋', '2025-03-05 00:31:34');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (13, '/api/upload/8.jpeg', 'b23087834', 2, '76051151863', '123123xs', '02', '余震南', '男', '21', '中国中山紫马岭商圈中山五路171号2号楼', '2025-03-05 16:47:15');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (14, '/api/upload/4.jpeg', 'b23013152', 4, '106265823', '123123xs', '02', '严震南', '男', '22', '中国北京市西城区西長安街373号7楼', '2025-03-06 17:26:49');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (15, '/api/upload/10.jpeg', 'b23098849', 6, '18125223465', '123123xs', '02', '陈子韬', '男', '22', '中国成都市锦江区人民南路四段897号36号楼', '2025-03-09 05:01:28');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (16, '/api/upload/7.jpeg', 'b23013277', 5, '2035515267', '123123xs', '02', '江震南', '男', '23', '中国广州市白云区机场路棠苑街五巷646号25号楼', '2025-03-09 01:22:19');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (17, '/api/upload/4.jpeg', 'b23007834', 2, '1015445185', '123123xs', '02', '汪杰宏', '男', '22', '中国北京市海淀区清河中街68号943号19室', '2025-03-07 01:25:42');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (18, '/api/upload/4.jpeg', 'b23081170', 4, '2850440999', '123123xs', '02', '刘杰宏', '男', '21', '中国成都市成华区双庆路745号华润大厦36室', '2025-03-06 01:50:22');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (19, '/api/upload/3.jpeg', 'b23047049', 1, '2831364252', '123123xs', '02', '郑宇宁', '男', '22', '中国成都市成华区玉双路6号700号49室', '2025-03-14 08:07:18');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (20, '/api/upload/10.jpeg', 'b23017867', 4, '2020082037', '123123xs', '02', '李秀英', '女', '21', '中国广州市白云区小坪东路346号华润大厦13室', '2025-03-11 20:45:05');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (21, '/api/upload/10.jpeg', 'b23025087', 1, '14861124848', '123123xs', '02', '江嘉伦', '男', '22', '中国上海市徐汇区虹桥路171号43楼', '2025-03-13 09:07:23');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (22, '/api/upload/8.jpeg', 'b23054340', 3, '7609505554', '123123xs', '02', '钱安琪', '女', '21', '中国中山乐丰六路151号16室', '2025-03-13 00:49:27');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (23, '/api/upload/1.jpeg', 'b23095301', 2, '283831168', '123123xs', '02', '廖宇宁', '男', '23', '中国成都市锦江区红星路三段338号华润大厦34室', '2025-03-05 21:18:18');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (24, '/api/upload/10.jpeg', 'b23036771', 6, '16057592270', '123123xs', '02', '余杰宏', '男', '22', '中国中山京华商圈华夏街517号1楼', '2025-03-05 19:45:49');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (25, '/api/upload/10.jpeg', 'b23095155', 5, '15926071075', '123123xs', '02', '尹宇宁', '男', '22', '中国中山乐丰六路705号2楼', '2025-03-13 23:51:57');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (26, '/api/upload/10.jpeg', 'b23024359', 3, '13759922012', '123123xs', '02', '张震南', '男', '22', '中国北京市東城区東直門內大街622号3栋', '2025-03-13 17:55:20');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (27, '/api/upload/10.jpeg', 'b23088761', 5, '205535797', '123123xs', '02', '石晓明', '男', '23', '中国广州市白云区小坪东路446号华润大厦28室', '2025-03-12 21:09:06');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (28, '/api/upload/3.jpeg', 'b23061143', 5, '13768761089', '123123xs', '02', '刘云熙', '男', '21', '中国成都市锦江区红星路三段384号42栋', '2025-03-09 20:46:34');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (29, '/api/upload/10.jpeg', 'b23067380', 2, '219711927', '123123xs', '02', '陈云熙', '男', '21', '中国上海市浦东新区橄榄路174号40室', '2025-03-05 02:47:28');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (30, '/api/upload/10.jpeg', 'b23079729', 4, '7559921704', '123123xs', '02', '何震南', '男', '22', '中国深圳龙岗区布吉镇西环路225号华润大厦6室', '2025-03-08 13:50:35');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (31, '/api/upload/5.jpeg', 'b23092068', 5, '7604135516', '123123xs', '02', '林子韬', '男', '22', '中国中山天河区大信商圈大信南路209号华润大厦1室', '2025-03-10 08:17:06');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (32, '/api/upload/10.jpeg', 'b23067180', 4, '2055518723', '123123xs', '02', '朱睿', '男', '22', '中国广州市越秀区中山二路606号华润大厦6室', '2025-03-15 00:21:37');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (33, '/api/upload/7.jpeg', 'b23030784', 1, '14886471587', '123123xs', '02', '何子韬', '男', '22', '中国北京市西城区复兴门内大街189号23号楼', '2025-03-14 00:13:55');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (34, '/api/upload/10.jpeg', 'b23046226', 2, '76051939026', '123123xs', '02', '魏安琪', '女', '22', '中国中山京华商圈华夏街181号20栋', '2025-03-08 07:32:38');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (35, '/api/upload/10.jpeg', 'b23053416', 2, '7558905310', '123123xs', '02', '叶岚', '女', '22', '中国深圳罗湖区田贝一路736号华润大厦17室', '2025-03-11 09:21:46');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (37, '/api/upload/3.jpeg', 'b23092932', 4, '16047810646', '123123xs', '02', '周詩涵', '女', '22', '中国北京市延庆区028县道604号9栋', '2025-03-10 18:16:58');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (38, '/api/upload/10.jpeg', 'b23025758', 4, '13793518383', '123123xs', '02', '龙杰宏', '男', '21', '中国东莞珊瑚路636号华润大厦35室', '2025-03-08 14:26:56');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (39, '/api/upload/3.jpeg', 'b23039129', 1, '19331240681', '123123xs', '02', '卢岚', '女', '22', '中国广州市白云区机场路棠苑街五巷854号40楼', '2025-03-05 17:39:06');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (40, '/api/upload/9.jpeg', 'b23035645', 4, '285189699', '123123xs', '02', '金云熙', '男', '22', '中国成都市成华区双庆路849号40栋', '2025-03-09 00:13:06');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (41, '/api/upload/10.jpeg', 'b23068922', 4, '1035256216', '123123xs', '02', '汪嘉伦', '男', '22', '中国北京市西城区复兴门内大街523号30楼', '2025-03-14 21:47:45');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (42, '/api/upload/8.jpeg', 'b23074953', 4, '14333760363', '123123xs', '02', '钟子韬', '男', '22', '中国中山乐丰六路763号17室', '2025-03-08 06:45:08');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (43, '/api/upload/9.jpeg', 'b23029671', 5, '19839068561', '123123xs', '02', '魏秀英', '女', '22', '中国东莞环区南街二巷224号36室', '2025-03-06 17:40:49');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (44, '/api/upload/10.jpeg', 'b23036264', 3, '18249969618', '123123xs', '02', '汤岚', '女', '21', '中国东莞环区南街二巷919号19室', '2025-03-06 02:54:07');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (45, '/api/upload/7.jpeg', 'b23011130', 4, '14423865905', '123123xs', '02', '夏宇宁', '男', '21', '中国深圳罗湖区蔡屋围深南东路216号华润大厦21室', '2025-03-06 22:48:04');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (46, '/api/upload/10.jpeg', 'b23044011', 3, '213897863', '123123xs', '02', '马致远', '男', '23', '中国上海市黄浦区淮海中路713号21室', '2025-03-09 03:15:48');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (47, '/api/upload/4.jpeg', 'b23088698', 4, '13260143207', '123123xs', '02', '雷嘉伦', '男', '22', '中国北京市東城区東直門內大街979号50栋', '2025-03-07 03:36:29');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (48, '/api/upload/6.jpeg', 'b23016065', 4, '7607489353', '123123xs', '02', '韩嘉伦', '男', '23', '中国中山天河区大信商圈大信南路237号30楼', '2025-03-09 09:53:52');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (49, '/api/upload/10.jpeg', 'b23074712', 4, '14605555019', '123123xs', '02', '李嘉伦', '男', '22', '中国上海市浦东新区橄榄路526号36栋', '2025-03-05 22:01:48');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (50, '/api/upload/1.jpeg', 'b23052771', 5, '13358075076', '123123xs', '02', '何安琪', '女', '22', '中国深圳罗湖区田贝一路165号17号楼', '2025-03-14 18:44:40');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (51, '/api/upload/10.jpeg', 'b23073551', 3, '108039619', '123123xs', '02', '雷子韬', '男', '22', '中国北京市延庆区028县道848号46楼', '2025-03-11 19:15:55');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (52, '/api/upload/10.jpeg', 'b23012830', 3, '18828859249', '123123xs', '02', '于杰宏', '男', '23', '中国上海市徐汇区虹桥路871号4栋', '2025-03-06 16:57:52');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (53, '/api/upload/10.jpeg', 'b23078463', 5, '19984874446', '123123xs', '02', '于震南', '男', '22', '中国深圳龙岗区布吉镇西环路344号35室', '2025-03-11 19:55:47');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (54, '/api/upload/8.jpeg', 'b23036896', 4, '2090186496', '123123xs', '02', '孟子异', '男', '22', '中国广州市白云区机场路棠苑街五巷83号43室', '2025-03-14 22:24:17');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (55, '/api/upload/3.jpeg', 'b23092966', 3, '75563283488', '123123xs', '02', '杜岚', '女', '22', '中国深圳福田区景田东一街322号41号楼', '2025-03-06 04:08:11');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (56, '/api/upload/10.jpeg', 'b23018403', 5, '19684694593', '123123xs', '02', '杜宇宁', '男', '22', '中国成都市成华区双庆路489号1号楼', '2025-03-13 16:08:31');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (57, '/api/upload/1.jpeg', 'b23018677', 5, '2113678400', '123123xs', '02', '魏璐', '女', '22', '中国上海市浦东新区橄榄路430号23号楼', '2025-03-13 00:31:53');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (58, '/api/upload/2.jpeg', 'b23074937', 2, '204194230', '123123xs', '02', '张致远', '男', '23', '中国广州市天河区天河路47号36楼', '2025-03-12 21:37:49');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (59, '/api/upload/10.jpeg', 'b23013479', 4, '15661753495', '123123xs', '02', '熊杰宏', '男', '22', '中国上海市浦东新区健祥路257号9号楼', '2025-03-08 17:29:04');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (60, '/api/upload/10.jpeg', 'b23029573', 3, '19284820829', '123123xs', '02', '邓震南', '男', '21', '中国深圳福田区景田东一街741号38号楼', '2025-03-13 03:23:36');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (61, '/api/upload/2.jpeg', 'b23018101', 3, '7554650422', '123123xs', '02', '韩致远', '男', '22', '中国深圳罗湖区蔡屋围深南东路921号37室', '2025-03-12 16:59:31');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (62, '/api/upload/10.jpeg', 'b23031034', 3, '203486888', '123123xs', '02', '苏秀英', '女', '23', '中国广州市海珠区江南西路831号11楼', '2025-03-09 11:52:12');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (63, '/api/upload/8.jpeg', 'b23053867', 2, '214069054', '123123xs', '02', '苏晓明', '男', '22', '中国上海市徐汇区虹桥路650号48号楼', '2025-03-10 11:08:33');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (64, '/api/upload/10.jpeg', 'b23024703', 4, '286326921', '123123xs', '02', '叶震南', '男', '22', '中国成都市成华区双庆路123号华润大厦21室', '2025-03-12 15:12:19');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (65, '/api/upload/2.jpeg', 'b23091429', 2, '19037758113', '123123xs', '02', '向子韬', '男', '22', '中国中山天河区大信商圈大信南路252号31楼', '2025-03-11 10:50:39');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (66, '/api/upload/5.jpeg', 'b23086209', 5, '105997628', '123123xs', '02', '尹杰宏', '男', '23', '中国北京市海淀区清河中街68号748号华润大厦12室', '2025-03-09 01:42:12');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (69, '/api/upload/10.jpeg', 'b23088857', 1, '75522899496', '123123xs', '02', '熊睿', '男', '22', '中国深圳龙岗区学园一巷338号33栋', '2025-03-06 11:12:43');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (70, '/api/upload/9.jpeg', 'b23044199', 3, '19539534684', '123123xs', '02', '熊宇宁', '男', '21', '中国东莞环区南街二巷991号华润大厦36室', '2025-03-05 00:37:03');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (71, '/api/upload/10.jpeg', 'b23072103', 4, '107864741', '123123xs', '02', '何致远', '男', '22', '中国北京市延庆区028县道364号华润大厦42室', '2025-03-07 07:15:00');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (72, '/api/upload/10.jpeg', 'b23056400', 6, '101907901', '123123xs', '02', '刘子韬', '男', '21', '中国北京市朝阳区三里屯路776号49栋', '2025-03-07 09:49:50');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (73, '/api/upload/8.jpeg', 'b23005235', 4, '18841285294', '123123xs', '02', '何震南', '男', '22', '中国东莞环区南街二巷293号37室', '2025-03-09 18:45:09');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (74, '/api/upload/10.jpeg', 'b23090264', 4, '14607035344', '123123xs', '02', '范宇宁', '男', '22', '中国深圳福田区深南大道153号17室', '2025-03-15 08:58:35');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (75, '/api/upload/10.jpeg', 'b23016740', 1, '17392653384', '123123xs', '02', '何晓明', '男', '22', '中国北京市朝阳区三里屯路332号20栋', '2025-03-05 22:42:06');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (76, '/api/upload/6.jpeg', 'b23039036', 3, '2154557655', '123123xs', '02', '袁璐', '女', '22', '中国上海市浦东新区橄榄路537号34室', '2025-03-07 07:57:25');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (77, '/api/upload/2.jpeg', 'b23081680', 5, '16075147711', '123123xs', '02', '卢晓明', '男', '21', '中国东莞坑美十五巷353号29栋', '2025-03-07 21:01:32');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (78, '/api/upload/10.jpeg', 'b23004048', 2, '7600982280', '123123xs', '02', '谭璐', '女', '21', '中国中山京华商圈华夏街465号30室', '2025-03-09 00:46:04');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (79, '/api/upload/10.jpeg', 'b23028458', 3, '7554349395', '123123xs', '02', '徐嘉伦', '男', '22', '中国深圳罗湖区田贝一路550号21栋', '2025-03-13 17:49:09');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (80, '/api/upload/10.jpeg', 'b23004665', 6, '288722138', '123123xs', '02', '王云熙', '男', '22', '中国成都市锦江区红星路三段134号28楼', '2025-03-10 05:19:20');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (81, '/api/upload/8.jpeg', 'b23029341', 3, '76986241364', '123123xs', '02', '唐晓明', '男', '23', '中国东莞东泰五街681号25号楼', '2025-03-14 11:03:01');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (82, '/api/upload/2.jpeg', 'b23034284', 3, '18914796607', '123123xs', '02', '侯安琪', '女', '22', '中国北京市海淀区清河中街68号156号39楼', '2025-03-09 08:01:59');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (83, '/api/upload/8.jpeg', 'b23044327', 5, '19632085470', '123123xs', '02', '邱秀英', '女', '22', '中国深圳福田区深南大道905号11号楼', '2025-03-09 08:00:22');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (84, '/api/upload/10.jpeg', 'b23052533', 5, '16870688982', '123123xs', '02', '韩子异', '男', '23', '中国北京市海淀区清河中街68号261号10号楼', '2025-03-09 17:07:00');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (85, '/api/upload/10.jpeg', 'b23043962', 5, '108813333', '123123xs', '02', '崔子韬', '男', '21', '中国北京市西城区西長安街703号华润大厦46室', '2025-03-10 11:15:46');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (86, '/api/upload/10.jpeg', 'b23056244', 4, '76089800140', '123123xs', '02', '潘震南', '男', '22', '中国中山紫马岭商圈中山五路197号35楼', '2025-03-06 06:32:08');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (87, '/api/upload/8.jpeg', 'b23045495', 6, '18277777777', '123123xs', '02', '梁詩涵', '女', '21', '中国深圳罗湖区田贝一路571号38室', '2025-03-15 09:29:40');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (89, '/api/upload/8.jpeg', 'b23078228', 5, '109514073', '123123xs', '02', '龚詩涵', '女', '23', '中国北京市房山区岳琉路125号4栋', '2025-03-08 20:36:19');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (90, '/api/upload/5.jpeg', 'b23075547', 1, '14154642376', '123123xs', '02', '阎秀英', '女', '22', '中国深圳福田区景田东一街835号华润大厦43室', '2025-03-11 16:07:06');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (91, '/api/upload/2.jpeg', 'b23094169', 4, '14241736612', '123123xs', '02', '毛嘉伦', '男', '21', '中国深圳福田区景田东一街297号18号楼', '2025-03-06 22:29:46');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (92, '/api/upload/4.jpeg', 'b23052589', 5, '75590761914', '123123xs', '02', '邹安琪', '女', '21', '中国深圳福田区景田东一街440号23栋', '2025-03-10 08:43:28');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (93, '/api/upload/3.jpeg', 'b23078565', 2, '15646859661', '123123xs', '02', '萧致远', '男', '21', '中国广州市越秀区中山二路744号20室', '2025-03-05 04:17:25');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (94, '/api/upload/10.jpeg', 'b23087157', 3, '75506926064', '123123xs', '02', '赵子异', '男', '22', '中国深圳罗湖区清水河一路482号50号楼', '2025-03-05 23:16:56');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (95, '/api/upload/10.jpeg', 'b23088364', 4, '16786326635', '123123xs', '02', '林岚', '女', '23', '中国北京市西城区复兴门内大街860号42室', '2025-03-06 15:52:16');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (96, '/api/upload/10.jpeg', 'b23006644', 3, '16196053280', '123123xs', '02', '邹晓明', '男', '21', '中国上海市浦东新区橄榄路102号14楼', '2025-03-10 11:30:36');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (97, '/api/upload/3.jpeg', 'b23049694', 3, '203435299', '123123xs', '02', '蔡宇宁', '男', '23', '中国广州市越秀区中山二路248号17号楼', '2025-03-13 08:06:23');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (98, '/api/upload/10.jpeg', 'b23086781', 4, '18590836696', '123123xs', '02', '周致远', '男', '21', '中国北京市房山区岳琉路319号28号楼', '2025-03-11 05:20:29');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (99, '/api/upload/10.jpeg', 'b23096797', 6, '102759119', '123123xs', '02', '龚嘉伦', '男', '23', '中国北京市西城区复兴门内大街522号22室', '2025-03-07 12:55:59');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (100, '/api/upload/10.jpeg', 'b23000901', 5, '2036733696', '123123xs', '02', '龚宇宁', '男', '21', '中国广州市白云区机场路棠苑街五巷975号17楼', '2025-03-10 01:03:19');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (101, '/api/upload/6.jpeg', 'b23075246', 5, '17016465217', '123123xs', '02', '郝子异', '男', '22', '中国上海市黄浦区淮海中路400号华润大厦29室', '2025-03-05 07:44:28');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (246, '/api/upload/20250425200538.png', NULL, NULL, '18277777770', '123123qwe', '01', '测试', '男', '12', '阿萨德哈u的', '2025-04-25 20:06:08');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (247, NULL, '', 0, '18217786311', '123123xs', '01', NULL, NULL, NULL, NULL, '2025-04-26 12:17:32');
INSERT INTO `user` (`id`, `image`, `sno`, `cid`, `phone`, `password`, `type`, `realname`, `sex`, `age`, `address`, `create_time`) VALUES (248, NULL, 'b230151344', 1, '19036076862', '123123xs', '02', NULL, NULL, NULL, NULL, '2025-04-26 12:20:50');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
