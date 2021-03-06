USE [master]
GO
/****** Object:  Database [Assignment2_LeDuyTuanVu]    Script Date: 2/7/2021 5:21:11 AM ******/
CREATE DATABASE [Assignment2_LeDuyTuanVu]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Assignment2_LeDuyTuanVu', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Assignment2_LeDuyTuanVu.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Assignment2_LeDuyTuanVu_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Assignment2_LeDuyTuanVu_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Assignment2_LeDuyTuanVu].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET ARITHABORT OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET  MULTI_USER 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Assignment2_LeDuyTuanVu]
GO
/****** Object:  Table [dbo].[tblAnswers]    Script Date: 2/7/2021 5:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblAnswers](
	[answerID] [varchar](50) NOT NULL,
	[answerContent] [varchar](8000) NULL,
	[answerCorrect] [bit] NULL,
	[questionID] [varchar](50) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[answerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblQuestions]    Script Date: 2/7/2021 5:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblQuestions](
	[questionID] [varchar](50) NOT NULL,
	[questionContent] [varchar](8000) NULL,
	[createDate] [date] NULL,
	[subjectID] [varchar](50) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[questionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblQuizDetails]    Script Date: 2/7/2021 5:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblQuizDetails](
	[quizID] [varchar](50) NOT NULL,
	[questionID] [varchar](50) NOT NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[quizID] ASC,
	[questionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblQuizs]    Script Date: 2/7/2021 5:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblQuizs](
	[quizID] [varchar](50) NOT NULL,
	[subjectID] [varchar](50) NULL,
	[createQuiz] [varchar](50) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[quizID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblRoles]    Script Date: 2/7/2021 5:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblRoles](
	[roleID] [varchar](50) NOT NULL,
	[roleName] [varchar](50) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblSubjects]    Script Date: 2/7/2021 5:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblSubjects](
	[subjectID] [varchar](50) NOT NULL,
	[subjectName] [varchar](100) NULL,
	[numberQuestion] [int] NULL,
	[minute] [int] NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[subjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTakeQuizDetails]    Script Date: 2/7/2021 5:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTakeQuizDetails](
	[takeQuizID] [varchar](50) NOT NULL,
	[quizID] [varchar](50) NOT NULL,
	[questionID] [varchar](50) NOT NULL,
	[ansFinal] [varchar](50) NULL,
	[ansRight] [varchar](50) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[takeQuizID] ASC,
	[quizID] ASC,
	[questionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTakeQuizs]    Script Date: 2/7/2021 5:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTakeQuizs](
	[takeQuizID] [varchar](50) NOT NULL,
	[quizID] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[total] [float] NULL,
	[makeQuizDate] [varchar](50) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[takeQuizID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 2/7/2021 5:21:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUsers](
	[email] [varchar](50) NOT NULL,
	[password] [varchar](100) NULL,
	[fullName] [varchar](50) NULL,
	[roleID] [varchar](50) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer1', N'In linear probing of the open addressing method, the position in which key can be stored is found by sequentially searching starting from the begin of table.', 1, N'question1', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer10', N'The searching process in Cichelli''s algorithm is linear.', 0, N'question3', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer100', N'error_page', 0, N'question25', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer101', N'Any exceptions in the current page that are not caught are sent to the error page for processing. The error page implicit object exception references the original exception.', 1, N'question26', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer102', N'Specifies if the current page is an error page that will be invoked in response to an error on another page.', 0, N'question26', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer103', N'Specifies the MIME type of the data in the response to the client. The default type is text/html.', 0, N'question26', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer104', N'Specifies the class from which the translated JSP will be inherited.', 0, N'question26', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer105', N'JMS enhances access to email services', 0, N'question27', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer106', N'JMS uses JNDI to find destination', 0, N'question27', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer107', N'JMS uses JMX to create a connection Factory', 0, N'question27', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer108', N'JMS uses JMX to create a connection Factory and JMS uses JNDI to find destination', 1, N'question27', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer109', N'session -configuration', 1, N'question28', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer11', N'Cichelli''s method uses an exhaustive search.', 0, N'question3', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer110', N'webapp', 0, N'question28', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer111', N'session_config', 0, N'question28', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer112', N'session-config', 0, N'question28', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer113', N'It will be invoked only if doStartTag() and doAfterBody() complete successfully.', 0, N'question29', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer114', N'This method is invoked if doStartTag () method returns true.', 0, N'question29', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer115', N'It will be invoked only if doStartTag() or doAfterBody() return Tag.DO_END_TAG.', 0, N'question29', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer116', N'It will be invoked in all case even if doStartTag() or doAfterBody() throw an exception Tag.DO_END_TAG..', 1, N'question29', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer117', N'request.setAttribute(name, value);', 0, N'question30', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer118', N'request.getSession().setAttribute(name, value).;', 1, N'question30', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer119', N'response.setAttribute(name, value);', 0, N'question30', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer12', N'Cichelli''s algorithm guarantees that a perfect hash function can be found.', 0, N'question3', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer120', N'request.setParameter(name, value)', 0, N'question30', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer121', N'FWorks/WEB-INF', 0, N'question31', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer122', N'FWorks/classes', 0, N'question31', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer123', N'FWorks/WEB-INF/classes', 0, N'question31', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer124', N'FWorks/WEB-INF/lib/classes', 1, N'question31', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer125', N'Making something different than what exists.', 1, N'question32', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer126', N'Producing ideas that are unusual or unique.', 0, N'question32', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer127', N'Making something novel.', 0, N'question32', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer128', N' Widening the range of choices.', 0, N'question32', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer129', N'The firm belief that if you let your imagination soar, it will eventually come up with something novel.', 1, N'question33', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer13', N'Extendible hashing is directoryless technique.', 0, N'question4', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer130', N'The firm belief that we need to reinvent things constantly.', 0, N'question33', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer131', N'The firm belief that the ideas for solving challenges all exist.', 0, N'question33', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer132', N'The firm belief that it is always possible to create things not previously known.', 0, N'question33', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer133', N'Why? For whom? How? And last, what?', 0, N'question34', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer134', N'Who we serve? What they need? Why they need it? How to meet their need?', 1, N'question34', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer135', N'What to invent? How to invent it? And for whom we do this?', 0, N'question34', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer136', N'What to invent? And why we want to?', 0, N'question34', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer137', N'Creativity is fully determine by our nature (our genetic make-up).', 0, N'question35', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer138', N'There is no link whatsoever between genes and creativity.', 0, N'question35', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer139', N'Some people completely lack essential creativity genes.', 0, N'question35', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer14', N'Linear hashing is directory technique.', 0, N'question4', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer140', N'Creativity is not predetermined by your genes, though stimulation can ''turn on'' genes that foster creative ideas.', 1, N'question35', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer141', N'Trans-disciplinarity (the ability to combine several different disciplines, in seeking new ideas).', 1, N'question36', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer142', N'Athletic ability.', 0, N'question36', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer143', N'Ability to handle sums of money.', 0, N'question36', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer144', N'Knowledge of languages.', 0, N'question36', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer145', N'The villagers used social media to re-connect.', 0, N'question37', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer146', N'Engineers used solar panels to power village lighting.', 0, N'question37', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer147', N'The villagers used the midnight sun as a tourist attraction.', 0, N'question37', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer148', N'Clever engineers found a way to bring sunshine to the village square during the dark winter days.', 1, N'question37', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer149', N'A coffee-and-bakery food chain offered to let its customers decide how much to pay for the food they choose, including zero.', 1, N'question38', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer15', N'The characteristic feature of extendible hashing is the organization of the index, which is expandable table.', 1, N'question4', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer150', N'A coffee and bakery chain allowed homeless to sleep in its entryways.', 0, N'question38', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer151', N'A coffee and bakery chain created a low-price range of sandwiches.', 0, N'question38', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer152', N'A coffee and bakery chain offered a 25 % discount to those who could not pay.', 0, N'question38', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer153', N'Act, don''t gripe, then break the rules, break the chains of habit, be persistent.', 0, N'question39', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer154', N'Be persistent, then act don''t gripe, break the chains of habit, be persistent.', 0, N'question39', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer155', N'Break the rules, then be persistent, act don''t gripe, break the chains of habit.', 0, N'question39', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer156', N'Break the chains of habit, then be persistent, break the rules, act don''t gripe and habit. ', 1, N'question39', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer157', N'Creative people can overcome failure.', 0, N'question40', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer158', N'Creative people never give up.', 0, N'question40', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer159', N'Creative people know how to work well with others.', 0, N'question40', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer16', N'A reorganization of the file is avoided by using extendible hashing if the directory overflows.', 0, N'question4', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer160', N'Creative people give themselves, and others, permission to be wrong.', 1, N'question40', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer161', N'You cannot solve a problem unless you think out of the box.', 0, N'question41', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer162', N'You cannot solve a problem unless you have mastered your subject.', 0, N'question41', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer163', N'You cannot solve a problem unless you first convince yourself you can.', 0, N'question41', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer164', N'You cannot solve a problem with the same level of thinking that created it.', 1, N'question41', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer165', N'Is zero', 0, N'question42', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer166', N'Is much higher than the correlation between lifetime creative achievement and measured childhood creativity', 1, N'question42', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer167', N'Is much lower than the correlation between lifetime creative achievement', 0, N'question42', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer168', N'Is approximately equal to one-half', 0, N'question42', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer169', N'No, you are either born creative or not', 0, N'question43', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer17', N'If hash function transforms different keys into different numbers, it is called a perfect hash function.', 0, N'question5', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer170', N'Yes, but we have to start in day-care', 0, N'question43', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer171', N'Yes, I have done it, and my wife has done it, I have seen excellent teachers do it', 1, N'question43', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer172', N'No, not within the existing school system', 0, N'question43', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer173', N'Analysis: analyzing the problem', 0, N'question44', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer174', N'Preparation: gathering data', 0, N'question44', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer175', N'Ideation: developing ideas', 0, N'question44', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer176', N'Evaluation: Judge the resulting ideas', 1, N'question44', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer177', N'Smart rats'' performance relative to that of dumb rats improved when the environment of both was enriched', 1, N'question45', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer178', N'Dumb rats still performed less well than smart rats, when their environment was enriched', 0, N'question45', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer179', N'Dumb rats improved massively compared to smart rats', 0, N'question45', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer18', N'To create a hash function, the table has to contain at least the same number of positions as the number of elements being hashed.', 1, N'question5', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer180', N'Enriching rats'' environment had no impact on their performance', 0, N'question45', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer181', N'All the variables that discriminate between creative and non-creative people are related to IQ', 1, N'question46', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer182', N'None of the variables that discriminate between creative and non-creative', 0, N'question46', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer183', N'Some of the variables that discriminate between creative', 0, N'question46', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer184', N'All the variables that discriminate between creative and non-creative', 0, N'question46', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer185', N'If you know exactly what you are going to do, what is the point of doing it?', 1, N'question47', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer186', N'Work in your studio every day, and ideas will come', 0, N'question47', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer187', N'Hone your craft, your skills, before you try anything new', 0, N'question47', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer188', N'Carefully plan in advance if you want to innovate in art', 0, N'question47', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer189', N'The solution was consistent with the given constraint, the reduced thrust of the rocket launcher', 0, N'question48', 1)
GO
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer19', N'All of the others.', 0, N'question5', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer190', N'A Mars exploratory vehicle was sent instead to Venus as its final destination', 0, N'question48', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer191', N'A Mars exploratory vehicle was given solar panels to boost its range', 0, N'question48', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer192', N'A Mars exploratory vehicle was miniaturized, so that the rocket that launched it would be sufficiently powerful', 1, N'question48', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer193', N'The children learned to use the computers quickly, even without knowing English', 1, N'question49', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer194', N'The children got help from adults', 0, N'question49', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer195', N'The children did not know what the touch screen was for', 0, N'question49', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer196', N'The children learned to turn the screen off and on', 0, N'question49', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer197', N'The critics loved the opera but the audience did not', 0, N'question50', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer198', N'The audience loved it from the first moment', 0, N'question50', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer199', N'The audience loved the opera instantly but the critics panned it', 0, N'question50', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer2', N'Linear probing has a tendency to create clusters in the table.', 0, N'question1', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer20', N'None of the others', 0, N'question5', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer200', N'The audience and critics hated it, because it combined the traditions of comic opera and grand opera', 1, N'question50', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer201', N'The process of creating ''protocols'' (ordered steps to be done, for any situation)', 0, N'question51', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer202', N'The process of listing methodically all the steps you need for any given process', 0, N'question51', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer203', N'The process of measuring whatever you do, because ''management begins with measurement''', 0, N'question51', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer204', N'The process of identifying, understanding and sharing best practices, in order to identify gaps in performance and find areas for improvement', 1, N'question51', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer205', N'A technological innovation that led to market leadership', 1, N'question52', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer206', N'How strong management leads to global success', 0, N'question52', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer207', N'An innovation in the way business is conducted', 0, N'question52', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer208', N'How strong supply chain management', 0, N'question52', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer209', N'Perfecting the songs before recording them', 0, N'question53', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer21', N'In shift folding method, the key is usually divided into even parts of some fixed size plus some remainder.', 0, N'question6', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer210', N'Investing large sums in marketing', 0, N'question53', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer211', N'Innovate everywhere, including the musical instruments, songs, and even the album cover', 1, N'question53', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer212', N'Remaining focused on what your fans want and need', 0, N'question53', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer213', N'Try to stop smoking', 0, N'question54', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer214', N'Do everything you normally do, in your daily life, in a completely different manner', 1, N'question54', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer215', N'Avoid fast food', 0, N'question54', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer216', N'Observe how many times you eat the same food and wear the same clothing', 0, N'question54', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer217', N'In the field, in Spain, during the Spanish Civil War 1936-9', 1, N'question55', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer218', N'In an R&D lab in Poughkeepsie, New York', 0, N'question55', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer219', N'In his home kitchen', 0, N'question55', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer22', N'In boundary folding method, the key is usually divided into even parts of not fixed size plus some remainder and added.', 1, N'question6', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer220', N'In Britain, in a Cadbury''s factory', 0, N'question55', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer221', N'His 120-mph serve', 0, N'question56', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer222', N'Wearing down his opponent with long baseline rallies', 0, N'question56', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer223', N'Topspin forehands', 0, N'question56', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer224', N'Sticking stubbornly to his game strategy, even when he was down two sets and facing match defeat', 1, N'question56', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer225', N'Was popular even before he became President', 0, N'question57', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer226', N'Was a wealthy lawyer and businessman before entering politics', 0, N'question57', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer227', N'Was Governor of Illinois before attaining the Republican nomination', 0, N'question57', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer228', N'Lost elections for state legislature, Congress, Senate and the vice-presidential nomination', 1, N'question57', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer229', N'Visiting his father in Folsom', 0, N'question58', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer23', N'The shift folding method can be applied to string data.', 0, N'question6', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer230', N'Serving a prison term in Folsom', 0, N'question58', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer231', N'Reading about Folsom', 0, N'question58', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer232', N'The movie Inside the Walls of Folsom Prison', 1, N'question58', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer233', N'Exploring French villages in Normandy', 0, N'question59', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer234', N'Parisian cafes in Montmartre, frequented by well-dressed women', 1, N'question59', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer235', N'Reading history books about fashion', 0, N'question59', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer236', N'Walking the streets of New York and exploring', 0, N'question59', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer237', N'Formed the foundation of CDMA cell phone technology', 1, N'question60', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer238', N'Invented high-fidelity sound for motion pictures', 0, N'question60', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer239', N'Invented the lipstick tube', 0, N'question60', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer24', N'The boundary folding method can not be applied to string data.', 0, N'question6', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer240', N'Invented eye-lash thickener', 0, N'question60', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer241', N'Innovators need very good eyesight to spot trends', 0, N'question61', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer242', N'Innovators need to zoom in on the fine details of a creativity challenge (microscope) and zoom out on the big picture (telescope).', 1, N'question61', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer243', N'Innovators need to examine their products microscopically for flaws', 0, N'question61', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer244', N'Innovators must scour the world with a telescope, to find market opportunities', 0, N'question61', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer245', N'First build plan, then think about why you are doing this', 1, N'question62', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer246', N'Use the past to guide your future plans', 0, N'question62', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer247', N'Imagine your destination', 0, N'question62', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer248', N'Imagine your destination then plan step by step', 0, N'question62', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer249', N'Core strategy; company boundaries', 0, N'question63', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer25', N'Constant time', 0, N'question7', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer250', N'Core strategy; customer interface; strategic resources; value network', 1, N'question63', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer251', N'value network; customer benefits', 0, N'question63', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer252', N'Money; people; products; customers', 0, N'question63', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer253', N'Happy, comforting, exciting, clear, rapid, short, visual', 0, N'question64', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer254', N'Dynamic, modern, cool, young, fast-paced, animated, clever', 1, N'question64', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer255', N'Dynamic, modern, cool', 0, N'question64', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer256', N'Strong, exciting, distinct, authentic, consistent, clear', 0, N'question64', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer257', N'A Power Point presentation for potential investors', 0, N'question65', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer258', N'An Excel spreadsheet showing revenues and costs', 0, N'question65', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer259', N'A roadmap plan comprising a business design: how an idea can become a profitable sustained and growing business, and how the idea will be delivered', 1, N'question65', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer26', N'Logarithmic time', 1, N'question7', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer260', N'An Excel spreadsheet', 0, N'question65', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer261', N'The need; the product', 0, N'question66', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer262', N'The need; the product; the unique features', 0, N'question66', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer263', N'The team; the technology', 0, N'question66', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer264', N'The team; the technology; the profit margin; patents; competition', 1, N'question66', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer265', N'Comparing prices of alternative products and services', 1, N'question67', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer266', N'Introspection', 0, N'question67', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer267', N'Introspection, thinking what you yourself', 0, N'question67', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer268', N'Interviewing potential clients', 0, N'question67', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer269', N'The gap between cost and price', 1, N'question68', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer27', N'Linear time', 0, N'question7', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer270', N'Value and price', 0, N'question68', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer271', N'Cost and value', 0, N'question68', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer272', N'Cost', 0, N'question68', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer273', N'The gap between value', 0, N'question69', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer274', N'The gap between value and cost', 1, N'question69', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer275', N'The gap between cost', 0, N'question69', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer276', N'None of the others', 0, N'question69', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer277', N'How to defeat competitors', 0, N'question70', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer278', N'How to create unique value by product differentiate', 1, N'question70', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer279', N'How to maximize profit', 0, N'question70', 1)
GO
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer28', N'Quadratic', 0, N'question7', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer280', N'How to create unique value', 0, N'question70', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer281', N'They foster empowerment', 0, N'question71', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer282', N'They foster empowerment and innovation', 1, N'question71', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer283', N'They cause less internal friction', 0, N'question71', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer284', N'They are cheaper in terms of pay', 0, N'question71', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer285', N'Technology, preferences, psychology, marketing, regulation', 0, N'question72', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer286', N'Prices, technology, competition, entry barriers, regulation', 0, N'question72', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer287', N'Supplier power, barriers to entry, rivalry, buyer power, threat of substitute', 1, N'question72', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer288', N'Supplier power, barriers to entry', 0, N'question72', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer289', N'A short sentence answering, for whom? Why they need it? How you will meet the need? And finally what you will innovate.', 1, N'question73', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer29', N'Two entries are identical except for their keys.', 0, N'question8', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer290', N'A short sentence showing why your idea will succeed', 0, N'question73', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer291', N'A statement showing the social benefits to society', 0, N'question73', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer292', N'A short sentence answering, for whom', 0, N'question73', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer293', N'A visual portrayal of your products'' key features and their performance, relative to alternative products', 1, N'question74', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer294', N'A design sketch showing how your product will look', 0, N'question74', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer295', N'A comprehensive list of all the features of your product', 0, N'question74', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer296', N'A visual portrayal of your products'' key', 0, N'question74', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer297', N'Better design, better quality, better cost, better distribution', 1, N'question75', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer298', N'Eliminate; raise; reduce; and create', 0, N'question75', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer299', N'Cheaper, faster, easier, quicker', 0, N'question75', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer3', N'Using quadratic probing gives much better results than linear probing and avoids the problem of cluster buildup.', 0, N'question1', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer30', N'Two entries with different data have the exact same key.', 0, N'question8', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer300', N'Better design, better quality', 0, N'question75', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer301', N'A map showing the steps you need to take to deliver your product', 0, N'question76', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer302', N'Shows the key processes and sub-processes that together comprise the system that creates value for your customers', 1, N'question76', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer303', N'A list of the activities you need to carry out', 0, N'question76', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer304', N'Shows the key processes and sub-processes', 0, N'question76', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer305', N'Large stores; good parking', 0, N'question77', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer306', N'Large stores; good parking; food; playroom for kids', 1, N'question77', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer307', N'Quality, design, price, variety', 0, N'question77', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer308', N'Limited customer service; self-selection; modular design; low manufacturing cost', 0, N'question77', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer309', N'Flexible union contracts, fast turnaround, improved food, no luggage checking', 0, N'question78', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer31', N'Two entries with different keys have the same.', 0, N'question8', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer310', N'Point to point flights, new aircraft, courteous personnel, motivated employees', 0, N'question78', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer311', N'Low prices, limited passenger service, on-time departures; use of midsize city airports and Point to point flights, new aircraft, courteous personnel, motivated employees', 1, N'question78', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer312', N'Point to point flights', 0, N'question78', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer313', N'A set of shared assets, shared by products', 0, N'question79', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer314', N'A portfolio of various products', 0, N'question79', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer315', N'A portfolio of various products and services', 0, N'question79', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer316', N'A production setup that can produce a variety of products', 1, N'question79', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer317', N'Rapid redesign of mass produced products to meet new needs', 0, N'question80', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer318', N'Making one of a kind products by hand', 0, N'question80', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer319', N'Tailoring products to customer', 0, N'question80', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer32', N'Two entries with the exact same key have different hash values.', 1, N'question8', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer320', N'Tailoring products to customer preferences provided prior to production', 1, N'question80', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer321', N'To make sure all past mistakes are identified', 0, N'question81', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer322', N'To pin the blame on those responsible for failure', 0, N'question81', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer323', N'To ensure learning from the past leads to a better future', 1, N'question81', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer324', N'To ensure learning from the past', 0, N'question81', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer33', N'256', 0, N'question9', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer34', N'511', 0, N'question9', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer35', N'024', 0, N'question9', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer36', N'None of the others', 1, N'question9', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer37', N'Division', 0, N'question10', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer38', N'Folding', 0, N'question10', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer39', N'Extraction', 0, N'question10', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer4', N'For quadratic probing, the size of table should not be an even number.', 0, N'question1', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer40', N'All of the others.', 1, N'question10', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer41', N'Quadratic probing eliminates primary clustering but suffers from the less severe secondary clustering.', 0, N'question11', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer42', N'In double hashing the step size depends on the key and is obtained from a secondary hash function.', 0, N'question11', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer43', N'In quadratic probing the offset from x is the square of the step number, so the probe goes to x, x+1, x+2, x+3, x+4, and so on.', 1, N'question11', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer44', N'None of the others.', 0, N'question11', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer45', N'Cichelli''s method', 0, N'question12', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer46', N'Folding', 0, N'question12', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer47', N'Chaining', 0, N'question12', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer48', N'None of the others', 1, N'question12', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer49', N'Each position of the table is associated with a linked list or chain of structures whose info fields store keys or references', 0, N'question13', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer5', N'Coalesced hashing combines linear probing with chaning.', 0, N'question2', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer50', N'The collision is resolved by finding an available table entry other than the position to which the colliding key is originally hashed', 1, N'question13', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer51', N'The collision is resolved by finding a free memory area to store any collision', 0, N'question13', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer52', N'A free memory area is opened for storing keys', 0, N'question13', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer53', N'In chaining, some positions of the table is associated with a linked list or chain of structures whose info fields store keys or references to keys', 1, N'question14', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer54', N'In this method, the table can never overflow if free memory is available, because the linked list is extendible.', 0, N'question14', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer55', N'In chaining, the linked-list is used instead of array for a hash table', 0, N'question14', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer56', N'None of others', 0, N'question14', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer57', N'There is no maximum', 1, N'question15', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer58', N'2048', 0, N'question15', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer59', N'21024', 0, N'question15', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer6', N'In chaining, searches always fast if using linked lists.', 0, N'question2', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer60', N'1024', 0, N'question15', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer61', N'All of the others.', 0, N'question16', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer62', N'Two entries with different data have the exact same key.', 0, N'question16', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer63', N'Two entries are identical except for their keys.', 0, N'question16', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer64', N'Two entries with the exact same key have different hash values', 1, N'question16', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer65', N'No matter how many data items there are, insertion and searching', 0, N'question17', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer66', N'If the chaining method is used for collision resolution, insertion and searching', 1, N'question17', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer67', N'The expected complexity of hashing algorithm is O( 1 ).', 0, N'question17', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer68', N'If the coalesced method is used for collision resolution', 0, N'question17', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer69', N'In coalesced hashing, the linked list is created inside the hash table and a colliding key is put in the first available position of the table.', 0, N'question18', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer7', N'Self-organizing linked lists can be used to improve performance in chaining.', 1, N'question2', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer70', N'In coalesced hashing, the linked list is created outside the hash table and a colliding keys are put in the list connected to the colliding position of the table.', 0, N'question18', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer71', N'Because in coalesced hashing, the linked list is created inside the hash table, thus the searching must be carried out sequentially.', 0, N'question18', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer72', N'In coalesced hashing, the linked list is created inside the hash table. Each position pos in the table contains 2 fields: info and next. The next field contains the index of the next key that is hashed to pos.', 1, N'question18', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer73', N'HashTable', 0, N'question19', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer74', N'Linked List', 0, N'question19', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer75', N'Connected Graph', 1, N'question19', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer76', N'Priority Queue', 0, N'question19', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer77', N'Linear probing', 0, N'question20', 1)
GO
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer78', N'Quadractic probing', 1, N'question20', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer79', N'Double', 0, N'question20', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer8', N'Linked list can be used in Bucket Addressing.', 0, N'question2', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer80', N'Open', 0, N'question20', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer81', N'Extraction', 0, N'question21', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer82', N'Radix transformation', 1, N'question21', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer83', N'Folding', 0, N'question21', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer84', N'Mid-square', 0, N'question21', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer85', N'A5-B5', 0, N'question22', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer86', N'A5-A2-A3', 0, N'question22', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer87', N'A5-B2-C2', 0, N'question22', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer88', N'A5-B5-A9-B9', 1, N'question22', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer89', N'Scriptlets', 0, N'question23', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer9', N'Cichelli''s method is used to hash relatively small number of reserved words.', 1, N'question3', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer90', N'Expressions', 0, N'question23', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer91', N'Declarations', 0, N'question23', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer92', N'Declarations and Declarations', 1, N'question23', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer93', N'getField("email") of HttpServletRequest', 0, N'question24', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer94', N'getFormValue("email") of HttpServletRequest', 1, N'question24', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer95', N'getParameter("email") of ServletRequest', 0, N'question24', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer96', N'getParameters("email") ofHttpServlet', 0, N'question24', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer97', N'error-location', 1, N'question25', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer98', N'error', 0, N'question25', 1)
INSERT [dbo].[tblAnswers] ([answerID], [answerContent], [answerCorrect], [questionID], [status]) VALUES (N'answer99', N'error-page', 0, N'question25', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question1', N'Which of the following statement about Open Addressing are false', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question10', N'Which of the following hashing methods can cause collisions?', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question11', N'Consider open addressing method, select an incorrect statement.', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question12', N'Which of the following methods is used to collision resolution', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question13', N'Specify the correct statement about open addressing method for handling collision', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question14', N'Specify the most correct statement about chaining method for handling collision', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question15', N'A chained hash table has an array size of 1024. What is the maximum number of entries that can be placed in the table ?', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question16', N'Which of the following definitions about a collision in a hash table are incorrect ?', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question17', N'Specify the correct statement about hashing algorithm (Select the best answer).', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question18', N'Specify the correct statement about coalesced chaining method for handling collision', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question19', N' The Java Collections Framework contains a Map interface. An implementation of this interface is ...', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question2', N'Which of the following statement are true', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question20', N'The most common algorithm to apply when such collisions occur is to simply put the new item in the next available component. What is the name of this coliision resolution algorithm ?', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question21', N'What type of the hash functions that can be used in an English - Vietnamese dictionary ?', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question22', N'Using the coalesced hashing to put the following values in a table with 10 elements: A5, A2, A3, B5, A9, B2, B9, C2 Using the extraction method to extract the number as the key. What is the chain to begin with A5?', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question23', N'JSP ________ let you insert arbitrary code into the servlet''s _JspService method (which is called by service). Scriptlets.', CAST(N'2021-02-04' AS Date), N'subject2', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question24', N'Consider the HTML code below. Which of the following method calls can retrieve the "email" value sent from the browser ?', CAST(N'2021-02-04' AS Date), N'subject2', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question25', N'Which of the following elements are used for error handling and are child elements of <web-app> of a deployment descriptor ?', CAST(N'2021-02-04' AS Date), N'subject2', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question26', N'Which statements are BEST describe isErrorPage attribute of <%@ page isErrorPage=....%> directive ?', CAST(N'2021-02-04' AS Date), N'subject2', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question27', N'Which is the CORRECT statement about JMS ?', CAST(N'2021-02-04' AS Date), N'subject2', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question28', N'Identify the parent element of <session-timeout> element in web.xml', CAST(N'2021-02-04' AS Date), N'subject2', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question29', N'In which of the following cases will the method doEndTag() of a tag handler be invoked ?', CAST(N'2021-02-04' AS Date), N'subject2', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question3', N'Which of the following statement about Perfect Hash Functions are true', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question30', N'Which of the following statement correctly store an object associated with a name at a place where all the servlets/jsps of the same webapp participating in a session can access it? Assume that request, response, name, value etc. are references to objects of appropriate types.', CAST(N'2021-02-04' AS Date), N'subject2', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question31', N'Your web application named "FWorks" uses SpecialMath...class. This is an unbundled class and is not contained in any jar file. Where will you keep this class file?', CAST(N'2021-02-04' AS Date), N'subject2', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question32', N'In this course, creativity is defined as', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question33', N'In this course, the essence of discovery is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question34', N'In the process of discovering new ideas, the best sequence of questions is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question35', N'The link between creativity and genes is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question36', N'Among the 10 skills vital for having creative ideas, skills that you need now, is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question37', N'In the case study about the far-north Norwegian village, Rjukan,', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question38', N'In the case study "Panera cares" the creative idea demonstrated in this case is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question39', N'This course provides 10 creativity "exercises". The suggested order of the exercises is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question4', N'Select correct statements', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question40', N'IBM mentor Louis Mobley offered 6 principles for greater creativity. One of the principles states', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question41', N'Einstein once said, about problem solving', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question42', N'In Torrance''s research, the correlation between adults'' lifetime creative achievement and their childhood IQ', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question43', N'A leading expert on creativity, E. Paul Torrance, believes that with regard to teaching children to be creative', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question44', N'In Alex Osborn''s 7 step model for creative thinking, the final step is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question45', N'In the famous study by Cooper and Zubeck (1958),', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question46', N'The creativity researcher John Hayes found that', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question47', N'Pablo Picasso (1881-1973) famously said, about his own approach to creating new ideas in art', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question48', N'The famous NASA example of the Mars exploratory vehicle shows creative thinking IN the box because', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question49', N'In a famous experiment known as "Hole in the Wall", an Indian researcher mounted touch-screen computers in a wall in a Delhi slum, and found', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question5', N'Which of the following statement is true', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question50', N'George Bizet''s opera Carmen is one of the world''s most beloved and best-known operas; when it was first performed', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question51', N'Benchmarking is defined as', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question52', N'Dell Computer co, founded by Michael Dell in Austin Texas, is a strong example of', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question53', N'The Beatles'' album Sergeant Pepper''s Lonely Hearts Club Band is a strong example of', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question54', N'To break the ''chains of habit'', a creativity exercise, it is recommended that you', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question55', N'The original idea for M&M''s, a key product of a profitable successful candy company known as Mars, was discovered by an American, Forrest Mars', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question56', N'In one of the longest tennis matches in history, Rafael Nadal defeated Roger Federer 6-4, 6-4, 6-7, 6-7, 9-7; Nadal attributes his victory to', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question57', N'Abraham Lincoln, widely regarded as America''s greatest President, elected in 1860', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question58', N'Country singer Johnny Cash was inspired to write one of his greatest songs, about Folsom Prison, by', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question59', N'Fashion designer Yves St. Laurent got inspiration for some of his designs from', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question6', N'Select correct statements', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question60', N'The famous movie star Hedy Lamarr, once regarded as the world''s most beautiful woman, is responsible for a U.S. Patent that', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question61', N'The metaphor "microscope/telescope" conveys the idea that', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question62', N'What does "think ahead backward" mean in practice?', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question63', N'What is a business design? What are the four key elements of a business ?', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question64', N'What are the 7 key elements of a clear value "message"?', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question65', N'What is a business plan ?', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question66', N'What are the 5 key elements of every business plan ?', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question67', N'Value is determined by', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question68', N'"Social margin" is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question69', N'Client margin is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question7', N'What is the worst-case time for binary search finding a single item in an array?', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question70', N'What is the simplest definition of strategy ?', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question71', N'Why are more companies trying to implement ''flat'' structures in place of pyramidal hierarchies ?', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question72', N'What are the five competitive forces that drive an industry ?', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question73', N'A UVP unique value proposition is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question74', N'A value innovation curve (or profile) is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question75', N'The four actions for creating a new value curve are', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question76', N'An activity map', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question77', N'Ikea''s activity map has four key ''black circles''', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question78', N'Southwest Airline''s activity map features', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question79', N'A product platform is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question8', N'What is the best definition of a collision situation in a hash table ?', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question80', N'Mass customization, a special case of platform strategy, is', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question81', N'Why should every person, every team, every business practice "debrief"?', CAST(N'2021-02-04' AS Date), N'subject3', 1)
INSERT [dbo].[tblQuestions] ([questionID], [questionContent], [createDate], [subjectID], [status]) VALUES (N'question9', N'A chained hash table has an array size of 512. What is the maximum number of entries that can be placed in the table ?', CAST(N'2021-02-04' AS Date), N'subject1', 1)
INSERT [dbo].[tblRoles] ([roleID], [roleName], [status]) VALUES (N'AD', N'Admin', 1)
INSERT [dbo].[tblRoles] ([roleID], [roleName], [status]) VALUES (N'ST', N'Student', 1)
INSERT [dbo].[tblSubjects] ([subjectID], [subjectName], [numberQuestion], [minute], [status]) VALUES (N'subject1', N'CSD201', 28, 30, 1)
INSERT [dbo].[tblSubjects] ([subjectID], [subjectName], [numberQuestion], [minute], [status]) VALUES (N'subject2', N'PRJ321', 24, 30, 1)
INSERT [dbo].[tblSubjects] ([subjectID], [subjectName], [numberQuestion], [minute], [status]) VALUES (N'subject3', N'SYB303', 20, 20, 1)
INSERT [dbo].[tblUsers] ([email], [password], [fullName], [roleID], [status]) VALUES (N'admin@fpt.edu.vn', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'Admin', N'AD', 1)
INSERT [dbo].[tblUsers] ([email], [password], [fullName], [roleID], [status]) VALUES (N'vuldtse141057@fpt.edu.vn', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'Le Duy Tuan Vu', N'ST', 1)
ALTER TABLE [dbo].[tblAnswers]  WITH CHECK ADD FOREIGN KEY([questionID])
REFERENCES [dbo].[tblQuestions] ([questionID])
GO
ALTER TABLE [dbo].[tblQuestions]  WITH CHECK ADD FOREIGN KEY([subjectID])
REFERENCES [dbo].[tblSubjects] ([subjectID])
GO
ALTER TABLE [dbo].[tblQuizDetails]  WITH CHECK ADD FOREIGN KEY([questionID])
REFERENCES [dbo].[tblQuestions] ([questionID])
GO
ALTER TABLE [dbo].[tblQuizDetails]  WITH CHECK ADD FOREIGN KEY([quizID])
REFERENCES [dbo].[tblQuizs] ([quizID])
GO
ALTER TABLE [dbo].[tblQuizs]  WITH CHECK ADD FOREIGN KEY([subjectID])
REFERENCES [dbo].[tblSubjects] ([subjectID])
GO
ALTER TABLE [dbo].[tblTakeQuizDetails]  WITH CHECK ADD FOREIGN KEY([ansFinal])
REFERENCES [dbo].[tblAnswers] ([answerID])
GO
ALTER TABLE [dbo].[tblTakeQuizDetails]  WITH CHECK ADD FOREIGN KEY([ansRight])
REFERENCES [dbo].[tblAnswers] ([answerID])
GO
ALTER TABLE [dbo].[tblTakeQuizDetails]  WITH CHECK ADD FOREIGN KEY([questionID])
REFERENCES [dbo].[tblQuestions] ([questionID])
GO
ALTER TABLE [dbo].[tblTakeQuizDetails]  WITH CHECK ADD FOREIGN KEY([quizID])
REFERENCES [dbo].[tblQuizs] ([quizID])
GO
ALTER TABLE [dbo].[tblTakeQuizDetails]  WITH CHECK ADD FOREIGN KEY([takeQuizID])
REFERENCES [dbo].[tblTakeQuizs] ([takeQuizID])
GO
ALTER TABLE [dbo].[tblTakeQuizs]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[tblUsers] ([email])
GO
ALTER TABLE [dbo].[tblTakeQuizs]  WITH CHECK ADD FOREIGN KEY([quizID])
REFERENCES [dbo].[tblQuizs] ([quizID])
GO
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD FOREIGN KEY([roleID])
REFERENCES [dbo].[tblRoles] ([roleID])
GO
USE [master]
GO
ALTER DATABASE [Assignment2_LeDuyTuanVu] SET  READ_WRITE 
GO
