--Drop Database Snppts_DB
--GO

use master
GO

CREATE LOGIN naweed WITH PASSWORD='bigStrongPwd$'
GO

Create database Snppts_DB;
GO

use Snppts_DB;
GO

CREATE USER naweed FOR LOGIN naweed   
WITH DEFAULT_SCHEMA = dbo
GO


Create table dbo.Snippet
(
    Slug nvarchar(100) PRIMARY KEY,
    Title nvarchar(200),
    Description nvarchar(4000),
    ContainsAndroidSample bit,
    ContainsiOSSample bit,
    ContainsUWPSample bit,
    BuiltWith nvarchar(20), --Coming from DSK
    ExternalUri nvarchar(200),
    GithubUri nvarchar(200),
    AuthorGithubHandle nvarchar(50),
	GithubStars int,
	GithubLastUpdatedDate datetime,
    IsValidSnippet bit
)
GO
 

Create table dbo.Snippet_Image
(
    Slug nvarchar(100),
    ImageUri nvarchar(200)
)
GO
 

Create table dbo.Snippet_Category
(
    Slug nvarchar(100) ,
    Category nvarchar(50)
)
GO


Create table dbo.Author
(
    GitHubHandle nvarchar(50) PRIMARY KEY,
    FirstName nvarchar(100),
    LastName nvarchar(100),
    Website nvarchar(200),
    TwitterHandle nvarchar(50),
    GravatarHash nvarchar(100)
)
GO



DROP PROCEDURE IF EXISTS [dbo].[sp_Get_All_Snippets]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Get_All_Snippets]
AS
BEGIN

	--Return All Authors
	select	A.*
	from	Author A with (nolock)
	order by 
			A.FirstName, A.LastName

	--Return All Snippets
	select	A.*
	from	Snippet A with (nolock)
	join	Author B with (nolock) on A.AuthorGithubHandle = B.GitHubHandle
    where   A.IsValidSnippet = 1
	order by 
			A.Slug

	--Return All Snippet Images
	select	A.*
	from	Snippet_Image A with (nolock)
	order by
			A.Slug

	--Return All Snippet Categories
	select	A.*
	from	Snippet_Category A with (nolock)
	order by
			A.Slug

END
GO

GRANT EXECUTE ON [dbo].[sp_Get_All_Snippets] to naweed
GO


insert [Author] ([GitHubHandle],[FirstName],[LastName],[Website],[TwitterHandle],[GravatarHash])
select N'ahdbk',N'Ahd',N'Ben Kheder',N'http://supersharp.tech/',N'ahd_bk',N'6d7da8e2cc214f1e40f301ffee72ef5c' UNION ALL
select N'aimore',N'Aimoré',N'Sá',N'https://aimore.github.io/',N'Aimore_Sa',N'0601a7c390df793c7b308ac36860fcf7' UNION ALL
select N'AizenDong',N'Abdoulaye',N'Dong',NULL,N'AbdoulayeDong',N'b587892e4a08e593dff65a014337e8ee' UNION ALL
select N'alexandresanlim',N'Alexandre',N'Sanlim',N'https://alexandresanlim.github.io/',N'alexandresanlim',N'201e2428b23bfe48fbb3e02e54f6652d' UNION ALL
select N'Altevir',N'Altevir',N'Cardoso Neto',N'https://www.linkedin.com/in/altevir-cardoso-neto-178b8432/',N'AltevirNeto',N'0e8c3705b97841efdda6a01416f01d40' UNION ALL
select N'Amaro96',N'Amaro',N'Manungu',N'https://www.linkedin.com/in/amaro-manungu-729837162',N'amaro_manungu',N'2f4e0baf3efd3c1d497e79f5af9c399c' UNION ALL
select N'andreas-nesheim',N'Andreas',N'Nesheim',N'https://www.andreasnesheim.no/',N'AndreasNesheim',N'3f1d141d2809114debffb23277e91e3e' UNION ALL
select N'AnthonyLatty',N'Marc-Anthony',N'Latty',N'http://youniti-labs.herokuapp.com/',N'gifted_byte',N'1073fd60fa74ba67648c8b18ed9cf9fa' UNION ALL
select N'attrib75',N'Patrick',N'Goode',N'http://patrickgoode.com/',N'PatrickGoode',N'c24f10a93ab9762963ad27206655fea2' UNION ALL
select N'behl1anmol',N'Anmol',N'Behl',N'https://www.nerdpitch.me/',N'behl1anmol',N'd76775c90c17ab76a8d52e9d5e1ee069' UNION ALL
select N'cemahseri',N'Yunus Emre',N'AYGÜN',N'https://github.com/cemahseri',N'',N'' UNION ALL
select N'codeanees',N'Anees',N'Deen',N'https://github.com/codeanees',N'tweet2anees',N'19fa5b926ddc9d5c814e1eee6a5161ab' UNION ALL
select N'CrossGeeks',N'Charlin',N'Agramonte',N'https://xamgirl.com/',N'Chard003',N'7db2bb2eed17e8df7e78b0d5461d90b0' UNION ALL
select N'DamianSuess',N'Damian',N'Suess',N'https://suesslabs.com/',N'',N'5e39caab2d1ae3cf43efb99a2bfd4d4b' UNION ALL
select N'damiendoumer',N'Damien',N'Doumer',N'https://doumer.me/',N'Damien_Doumer',N'ecdd93df62c61daa04da17967f82d08d' UNION ALL
select N'DanielCauser',N'Daniel John',N'Causer',NULL,N'danielcauser',N'2666956714a2c2d48c480a6bddac4071' UNION ALL
select N'danimonettelli',N'Daniel',N'Monettelli',N'https://danimonettelli.github.io/',N'DaniMonettelli',N'4b3d0e60019ad8fe1e4d7cd5c8850efb' UNION ALL
select N'davidortinau',N'David',N'Ortinau',N'https://dev.to/davidortinau',N'davidortinau',N'8ae9ed744e4a1e6eb80c8b1cdf94b3e4' UNION ALL
select N'devoirtechsandip',N'Sandip',N'Kumbhar',N'http://devoirtech.com/',N'devoirtechIT',N'a97e280022876564d97bff2d333de8db' UNION ALL
select N'dnehl',N'Dominik',N'Nehl',N'https://www.nehl-it.com/',N'',N'8f0c7bda579c0865ddebfd65dc073015' UNION ALL
select N'egbakou',N'Kodjo Laurent',N'Egbakou',N'https://lioncoding.com/',N'lioncoding',N'6e26a030d3b9495872b58d922bd86157' UNION ALL
select N'ErickSilva2605',N'Erick',N'Augusto da Silva',N'https://www.linkedin.com/in/erick-augusto-silva/',N'',N'' UNION ALL
select N'exendahal',N'Santosh',N'Dahal',N'https://dahalsantosh.com.np/',N'exendahal',N'' UNION ALL
select N'felipebaltazar',N'Felipe',N'Baltazar',N'https://medium.com/@felipedasilvabaltazar',N'FelippeBaltazar',N'c4deac62305f590fbda80209628afd0e' UNION ALL
select N'haavamoa',N'Håvard',N'Moås',N'https://github.com/haavamoa',N'HavardMoas',N'3b316f33b1ca5e9f6da18e01432f7afe' UNION ALL
select N'hprez21',N'Héctor',N'Pérez',N'https://devs.school/',N'hprez',N'14e5bfbbff45352cf25bf80e42cbd34c' UNION ALL
select N'IeuanWalker',N'Ieuan',N'Walker',N'https://ieuanwalker.com/',N'IeuanTWalker',N'08d06d47d752c87ed40544362581cda1' UNION ALL
select N'InnovoTecnologias',N'Innovo',N'Tecnologías',N'https://www.innovotecnologias.com.ar/',N'',N'' UNION ALL
select N'ionixjunior',N'Ione',N'Souza Junior',N'https://www.ionixjunior.com.br/',N'ionixjunior',N'ca2812c8e2e51b07c5185663d1c3f033' UNION ALL
select N'jm-parent',N'Jean-Marie',N'Parent',N'https://www.jmparent.com/',N'jmparent_dev',N'd1d50caf99e1b66ab2c3bd82cf265f7f' UNION ALL
select N'jsuarezruiz',N'Javier',N'Suárez Ruiz',N'https://javiersuarezruiz.wordpress.com/',N'jsuarezruiz',N'dfe5d4830ab6c49995c24f8bc290437c' UNION ALL
select N'kainaalmeida',N'Kainã',N'Almeida',NULL,N'KainAlmeida',N'4c729c28e98f4aec8d214fc0e242e937' UNION ALL
select N'kevmoens',N'Kevin',N'Moens',N'https://github.com/kevmoens',N'kevmoens',N'e0752113efb103f1992c1b3eaca4ef5b' UNION ALL
select N'kphillpotts',N'Kym',N'Phillpotts',N'https://kymphillpotts.com/',N'kphillpotts',N'3218e66502c6f0836dfd0f02f210ba0b' UNION ALL
select N'leijae',N'Eric',N'Leija',N'https://www.mymealministry.com/',N'@F4UU0v2qYhCj8ds',N'' UNION ALL
select N'leroygumede',N'LeRoy',N'Gumede',NULL,N'',N'f051c3f6ce05ae70d60e013be2fafeb1' UNION ALL
select N'luciomsp',N'Vicente',N'Guzmán',N'https://vicenteguzman.mx/',N'luciomsp',N'72cce778aac0d6066a14225e90c30874' UNION ALL
select N'marcfabregatb',N'Marc',N'Fabregat',N'https://mfabregat.net/',N'Marcfabregatb',N'dfc303f9a1eda4c5fe768f8fa6932833' UNION ALL
select N'michaldivis',N'Michal',N'Diviš',N'https://github.com/michaldivis',N'',N'4284b13ced272ede8c9703f0605ed694' UNION ALL
select N'naweed',N'Naweed',N'Akram',N'https://blogs.xgenoapps.com/',N'xgeno',N'46335c2a2d6b939d3fb66e71f542eaab' UNION ALL
select N'nicholostyler',N'Nicholos',N'Tyler',N'https://github.com/nicholostyler',N'nicholostyler',N'c5f6b23c331e02229190bd023436339e' UNION ALL
select N'nogginbox',N'Richard',N'Garside',N'https://www.nogginbox.co.uk/',N'_richardg',N'af63a841553cea52069a553ae84d0628' UNION ALL
select N'RadekVyM',N'Radek',N'Vymětalík',N'https://github.com/RadekVyM',N'',N'' UNION ALL
select N'rdelrosario',N'Rendy',N'Del Rosario',N'https://xamboy.com/',N'rdelrosario',N'4bece0ce1c33e65177110bcb95688c68' UNION ALL
select N'ricardoprestes',N'Ricardo',N'Prestes',NULL,N'ricardo_prestes',N'9802e38d5bd2cd85db8b0720d5feed29' UNION ALL
select N'roubachof',N'Jean-Marie',N'Alfonsi',N'https://www.sharpnado.com/',N'piskariov',N'793803979d0ef8d047e83c86fd2ad67f' UNION ALL
select N'sankra',N'Runar Ovesen',N'Hjerpbakk',N'https://hjerpbakk.com/',N'hjerpbakk',N'62b1d11eafee92745a51971d6cc21f85' UNION ALL
select N'sattasundar',N'Satta',N'Sundar',N'https://github.com/sattasundar',N'sundarsatta',N'56d40a697b55b9813a5a6d356db0011d' UNION ALL
select N'sergy2k',N'Sergei',N'S',NULL,N'',N'' UNION ALL
select N'ShahrukhYousafzai',N'Shahrukh',N'Yousafzai',N'https://github.com/ShahrukhYousafzai',N'SRKYousafzaiPK',N'c3517b5c29751c62ff1d2198f21c20ba' UNION ALL
select N'shanranm',N'Shanmukha',N'Ranganath',NULL,N'IAMShanRanM',N'' UNION ALL
select N'shawyunz',N'Shaw',N'Yu',N'https://www.youtube.com/channel/UCmgk0PHlIvJ6TYt54VUEgHQ',N'shawyunz',N'aae1466b6e1a7a850d961fe13dbf4ad9' UNION ALL
select N'sthewissen',N'Steven',N'Thewissen',N'https://www.thewissen.io/',N'devnl',N'62ce0e69389e31fd3c42fb230f9b1637' UNION ALL
select N'syncfusion',N'Syncfusion',N'',N'https://www.syncfusion.com/',N'Syncfusion',N'4291ef07481d300471113dbd4b4aabc2' UNION ALL
select N'TBertuzzi',N'Thiago',N'Bertuzzi',NULL,N'',N'82d95125be475913cdc7a7fe319d0133' UNION ALL
select N'tsjdev-apps',N'Sebastian',N'Jensen',N'https://www.tsjdev-apps.de/',N'tsjdevapps',N'd990a05a189c263901ca94367d3a50be' UNION ALL
select N'tuyen-vuduc',N'Tuyen',N'Vu',N'https://tuyen-vuduc.dev/',N'tuyen_vuduc',N'd5efcc60b762dca8df19d3614d9b254a' UNION ALL
select N'ufukhawk',N'Ufuk',N'Sahin',N'https://codecanyon.net/user/xamdesign/portfolio',N'ufukhawk',N'04caa6410c1627f2ed3359a1a380266f' UNION ALL
select N'umeshkamble',N'Umesh',N'Kamble',N'https://github.com/umeshkamble',N'umeshkamble1984',N'' UNION ALL
select N'valentineg8',N'Lorenzo',N'Araujo',NULL,N'v_gr4y',N'' UNION ALL
select N'ValonK',N'Valon',N'Kastrati',NULL,N'vkcodez',NULL UNION ALL
select N'VladislavAntonyuk',N'Vladislav',N'Antonyuk',N'https://vladislavantonyuk.azurewebsites.net/',N'',N'c0b401631d8b65318905a76d8c643bad' UNION ALL
select N'WashingtonMorais',N'Washington',N'Morais',NULL,N'',N'';
GO
insert [Snippet] ([Slug],[Title],[Description],[ContainsAndroidSample],[ContainsiOSSample],[ContainsUWPSample],[BuiltWith],[ExternalUri],[GithubUri],[AuthorGithubHandle],[GithubStars],[GithubLastUpdatedDate],[IsValidSnippet])
select N'addcreditcard',N'Add Credit Card',N'Add a credit card from user',1,1,0,N'XAMARIN',NULL,N'alexandresanlim/XamarinUI.AddCreditCard',N'alexandresanlim',16,'2022-09-17 16:40:49.000',1 UNION ALL
select N'addtoshoppingcart',N'Add to Shopping Cart',N'Xamarin UI sample to add item to shopping cart',1,1,0,N'XAMARIN',NULL,N'alexandresanlim/XamarinUI.AddToShoppingCart',N'alexandresanlim',14,'2022-10-26 12:14:49.000',1 UNION ALL
select N'art-auction',N'Art Auction',N'Art Auction site, with multiple expanding popovers and interesting transitions',1,1,0,N'XAMARIN',N'https://kymphillpotts.com/xamarin-forms-ui-challenge-artauction.html',N'kphillpotts/ArtAuction',N'kphillpotts',114,'2022-11-12 14:27:06.000',1 UNION ALL
select N'avatar login',N'Avatar Login',N'This snippet was created to demonstrate a basic Login Page with animated avatar and some animation',1,1,0,N'XAMARIN',NULL,N'aimore/XamQuiz',N'aimore',2,'2021-08-11 11:35:03.000',1 UNION ALL
select N'band-tracker',N'Band Tracker',N'A simple music artist release and live show tracker app built with .NET MAUI.',1,1,0,N'MAUI',NULL,N'michaldivis/band-tracker-app',N'michaldivis',6,'2022-10-20 17:04:25.000',1 UNION ALL
select N'bet-app',N'Bet App',N'A Xamarin.Forms application based on Bet App design by Manoj Rajput from Dribbble.com.',1,0,0,N'XAMARIN',NULL,N'RadekVyM/Bet-App',N'RadekVyM',12,'2022-11-02 14:22:44.000',1 UNION ALL
select N'bottomappbar-material',N'BottomAppBar Material',N'This snippet was created to reproduce the Material BottomAppBar, originally from android using custom renderers and Xamarin.Forms Visual.Material.',1,1,0,N'XAMARIN',N'https://github.com/aimore/XamUI/tree/master/XamFood',N'aimore/XamUI',N'aimore',58,'2022-08-17 00:04:35.000',1 UNION ALL
select N'breadcrumb-control',N'Breadcrumb control',N'This is a breadcrumb navigation control that is completely automatic and uses the Navigation stack to get the page titles to generate the breadcrumbs.',1,1,0,N'MAUI',NULL,N'IeuanWalker/Maui.Breadcrumb',N'IeuanWalker',19,'2022-11-14 02:29:50.000',1 UNION ALL
select N'calling-app',N'Calling App',N'.NET MAUI implementation of majority wallet & calling design by Hampus Öhman from Dribbble.com.',1,1,1,N'MAUI',NULL,N'RadekVyM/Calling-App',N'RadekVyM',30,'2022-10-22 09:42:24.000',1 UNION ALL
select N'carousel-essentials',N'Carousel Essentials',N'A full app built only xamarin essentials features.',1,1,0,N'XAMARIN',NULL,N'alexandresanlim/App.CarouselEssentials',N'alexandresanlim',2,'2022-10-26 13:17:31.000',1 UNION ALL
select N'carousel-intro-page',N'Carousel Intro Page',N'Simple example of an introductory page in Xamarin.Forms.',1,1,0,N'XAMARIN',NULL,N'LucioMSP/Xamarin.Forms.Examples/tree/master/CarouselIntroPage',N'luciomsp',0,'2000-01-01 00:00:00.000',0 UNION ALL
select N'chameleon',N'Chameleon',N'A Xamarin.Forms version of the Chameleon app to prove you can create goodlooking UI with Xamarin.Forms as talked about in my blogpost.',1,1,0,N'XAMARIN',N'https://www.thewissen.io/creating-an-encyclopedia-page-in-xamarin-forms',N'sthewissen/KickassUI.Chameleon',N'sthewissen',74,'2022-08-07 06:15:48.000',1 UNION ALL
select N'Chased-Home-UI-Design',N'Chased Home UI Design',N'Xamarin Forms Chased Home UI Design',1,1,0,N'XAMARIN',NULL,N'ufukhawk/Chased-Home-UI-Design',N'ufukhawk',62,'2022-11-11 21:51:29.000',1 UNION ALL
select N'Chat app UI',N'FreeChat',N'User interface demonstrating a pretty chat application',1,1,0,N'XAMARIN',NULL,N'DamienDoumer/freechat',N'damiendoumer',171,'2022-11-07 09:55:53.000',1 UNION ALL
select N'chick-and-paddy-dotnet-maui',N'Chick and Paddy in MAUI',N'This snippet was created to demonstrate a well structured MAUI MVVM application. It uses feature-based, clean architecture and levarages all built-in MAUI controls.',1,1,0,N'MAUI',N'https://github.com/tuyen-vuduc/chick-and-paddy-dotnet-maui',N'tuyen-vuduc/chick-and-paddy-dotnet-maui',N'tuyen-vuduc',5,'2022-10-29 02:41:39.000',1 UNION ALL
select N'concentric-onboarding',N'Concentric OnBoarding',N'ConcentricOnboarding clone using skiasharp and xamarin forms based on SwiftUI Library exyte/ConcentricOnboarding',1,1,0,N'XAMARIN',N'https://medium.com/@felipedasilvabaltazar/xamarin-transições-com-skiasharp-6c8ac2b09589',N'felipebaltazar/Xam-ConcentricOnboarding',N'felipebaltazar',2,'2020-05-26 18:17:57.000',1 UNION ALL
select N'covid19-live',N'Covid-19 Live',N'Developed in XamarinForms with the aim of tracking Covid-19 cases with data from affected countries, including Brazil.',1,1,0,N'XAMARIN',NULL,N'Altevir/xamarinforms-covid19',N'Altevir',90,'2022-10-21 13:06:09.000',1 UNION ALL
select N'covid19-tracker-ui',N'Covid19 Tracker App',N'Covid19.Forms is a tracker app to keep updated with Covid19',1,1,0,N'XAMARIN',NULL,N'AnthonyLatty/Covid19.Forms',N'AnthonyLatty',9,'2021-09-15 15:40:38.000',1 UNION ALL
select N'CovidTrack',N'Covid Tracker',N'Developed with the intuition to show the flow of Covid-19 in the world with real data from each country',1,0,0,N'XAMARIN',NULL,N'Amaro96/CovidTrack',N'Amaro96',6,'2022-02-24 18:17:20.000',1 UNION ALL
select N'credit-card-checkout',N'Credit Card Checkout',N'A Xamarin.Forms UI Challenge based on a fantastic dribble design.',1,1,0,N'XAMARIN',N'https://lioncoding.com/2019/11/05/2019-11-05-Credit-Card-checkout-CarouselView-de-Xamarin-forms-4-3-en-action/',N'egbakou/CreditCardCheckout',N'egbakou',71,'2022-09-26 22:41:55.000',1 UNION ALL
select N'credit-card-payment-ui',N'MAUI Credit Card Payment UI',N'A sample credit card payment screen written using .NET MAUI and the Prism Library which runs on Windows, Android, iOS and Tizen.',1,1,1,N'MAUI',N'https://github.com/DamianSuess/Learn.MauiPaymentUi',N'DamianSuess/Learn.MauiPaymentUi',N'DamianSuess',8,'2022-09-29 18:05:23.000',1 UNION ALL
select N'cruise-mobile-ui',N'Cruise Mobile UI',N'A Xamarin.Forms UI Challenge based on a Behance design.',1,1,0,N'XAMARIN',N'https://www.andreasnesheim.no/xamarin-ui-challenge-cruise-mobile-ui-part-1/',N'andreas-nesheim/CruiseMobileUI',N'andreas-nesheim',11,'2022-04-15 14:29:09.000',1 UNION ALL
select N'Dark-Store',N'DarkStore',N'Xamarin Forms Dark Store UI Design',1,1,0,N'XAMARIN',NULL,N'ufukhawk/DarkStore',N'ufukhawk',39,'2022-10-28 09:51:16.000',1 UNION ALL
select N'dashboard-drawer',N'Dashboard Drawer',N'Dashboard with drawer',1,1,0,N'XAMARIN',NULL,N'AlexandreSanlim/XamarinUI.DashboardDrawer',N'alexandresanlim',26,'2022-08-03 17:21:01.000',1 UNION ALL
select N'day-vs-night',N'Day Vs Night',N'Gradients, so many gradients. Skia controls. User selectable themeing.',1,1,0,N'XAMARIN',N'https://kymphillpotts.com/xamarin-forms-ui-challenge-dayvsnight.html',N'kphillpotts/DayVsNight',N'kphillpotts',125,'2022-10-22 20:18:53.000',1 UNION ALL
select N'discover-gists',N'Discover Gists',N'It''s a simple discover gists from GitHub app',1,1,0,N'XAMARIN',NULL,N'alexandresanlim/DiscoverGists',N'alexandresanlim',2,'2021-04-25 20:15:31.000',1 UNION ALL
select N'dotnet-maui-bank',N'.NET MAUI Bank app',N'Replicate Monobank design.',1,1,1,N'MAUI',NULL,N'VladislavAntonyuk/MauiSamples/tree/main/MauiBank',N'VladislavAntonyuk',0,'2000-01-01 00:00:00.000',0 UNION ALL
select N'duolingo-clone',N'Duolingo Clone',N'A clone of the Duolingo app made with Xamarin.Forms. At moment, this app contains the lessons, stories, profile, ranking, store, the tab bar structure and custom navigation bar for each page. Some custom renderers was created for the floating action button in Android, tab bar and circular / horizontal progress bar.',1,1,0,N'XAMARIN',N'https://www.ionixjunior.com.br/duolingo-app-clone-com-xamarin-forms/',N'ionixjunior/XFAppDuolingoClone',N'ionixjunior',78,'2022-11-08 10:02:48.000',1 UNION ALL
select N'EcommerceUI',N'Ecommerce design with MAUI',N'Ecommerce design with NET MAUI (MVVM Pattern)',1,1,0,N'MAUI',NULL,N'exendahal/EcommerceMAUI',N'exendahal',21,'2022-11-14 18:27:06.000',1 UNION ALL
select N'Enlighten',N'Enlighten',N'A Xamarin.Forms application for Students.',1,1,0,N'XAMARIN',N'https://play.google.com/store/apps/details?id=com.devoirtech.enlighten',N'devoirtechsandip/SnpptsChallenge',N'devoirtechsandip',2,'2020-12-31 06:41:14.000',1 UNION ALL
select N'essential-ui-kit',N'Essential UI Kit',N'Free and beautiful XAML pages for Xamarin.Forms apps by <a href="https://www.syncfusion.com/xamarin-ui-controls" target="_blank">Syncfusion</a>',1,1,1,N'XAMARIN',N'https://www.syncfusion.com/xamarin-ui-controls',N'syncfusion/essential-ui-kit-for-xamarin.forms',N'syncfusion',984,'2022-11-16 14:11:41.000',1 UNION ALL
select N'f1tv',N'F1TV',N'My contribution for the MAUI UI July challenge by replicating the F1TV app.',1,1,0,N'MAUI',N'https://www.andreasnesheim.no/maui-ui-july-replicating-f1tv-app/',N'andreas-nesheim/MAUIUIJuly',N'andreas-nesheim',2,'2022-07-05 07:27:40.000',1 UNION ALL
select N'facebook-mobile-app-login-ui-clone',N'Facebook Mobile App Login UI Clone',N'Facebook Mobile App Login UI Clone in Xamarin Forms.',1,0,0,N'XAMARIN',NULL,N'SRKYousafzaiPK/FacebookMobileAppLoginUIClone',N'ShahrukhYousafzai',5,'2022-10-13 06:32:59.000',1 UNION ALL
select N'fancy-tutorial',N'Fancy Tutorial',N'A simple Xamarin.Forms tutorial screen as talked about in my blogpost.',1,1,0,N'XAMARIN',N'https://www.thewissen.io/simple-good-looking-app-tutorial',N'sthewissen/KickassUI.FancyTutorial',N'sthewissen',48,'2022-04-22 05:35:21.000',1 UNION ALL
select N'fashion-store-ui',N'Fashion Store UI',N'A Xamarin.Forms Fashion Store UI.',1,1,0,N'XAMARIN',NULL,N'valentineg8/FashionStore',N'valentineg8',57,'2022-07-18 08:30:09.000',1 UNION ALL
select N'foodapp',N'foodapp',N'FoodApp is an application focused on good practices that should be in the Styles of Xamarin.Forms.',1,1,1,N'XAMARIN',N'https://danimonettelli.github.io/',N'danimonettelli/XF_FoodApp',N'danimonettelli',28,'2022-07-18 22:40:14.000',1 UNION ALL
select N'four-seasons',N'Four Seasons',N'.NET MAUI implementation of 4 seasons mobile ui design by Riko Sapto Dimo from Dribbble.com.',1,1,1,N'MAUI',NULL,N'RadekVyM/FourSeasons',N'RadekVyM',21,'2022-10-22 11:38:37.000',1 UNION ALL
select N'gadgets-store-app',N'Gadgets Store App',N'.NET MAUI implementation of Gadgets Store App design by Sajon from Dribbble.com.',1,1,0,N'MAUI',NULL,N'RadekVyM/Gadgets-Store-App',N'RadekVyM',23,'2022-10-22 09:42:36.000',1 UNION ALL
select N'great-places',N'Great Places',N'A ListView layout that has images and overlayed profile and views indicators.',1,1,0,N'XAMARIN',NULL,N'kphillpotts/XamarinFormsLayoutChallenges',N'kphillpotts',237,'2022-11-09 02:16:20.000',1 UNION ALL
select N'health-tracker',N'Health Tracker',N'A Health Tracker app that helps keep weight goals.',1,1,0,N'MAUI',N'https://github.com/nicholostyler/Health-Tracker',N'nicholostyler/Health-Tracker',N'nicholostyler',1,'2022-09-18 17:06:37.000',1 UNION ALL
select N'homemadefood',N'Homemade Food',N'Recepies App for home cook',1,1,0,N'MAUI',NULL,N'ahdbk/MAUI.RecipiesApp',N'ahdbk',3,'2022-10-22 09:42:12.000',1 UNION ALL
select N'im-feeling-lucky',N'I''m Feeling Lucky',N'It''s a feeling lucky page with animations',1,1,0,N'XAMARIN',NULL,N'alexandresanlim/XamarinUI.ImFeelingLucky',N'alexandresanlim',5,'2020-09-14 13:39:54.000',1 UNION ALL
select N'initials-view',N'Initials View',N'Custom control for Android and/or iOS showing the initials of a provided name within a colorful circle.',1,1,0,N'XAMARIN',N'https://medium.com/@tsjdevapps/xamarin-forms-how-to-create-an-intials-view-as-custom-control-for-android-and-ios-e9b09223ed53',N'tsjdev-apps/xf-initialsview',N'tsjdev-apps',13,'2021-09-29 07:00:55.000',1 UNION ALL
select N'in-space',N'In Space',N'A simple but good looking Xamarin.Forms UI screen as talked about in my blogpost.',1,1,0,N'XAMARIN',N'https://www.thewissen.io/xamarin-forms-in-space',N'sthewissen/KickassUI.InSpace',N'sthewissen',45,'2022-01-28 15:31:41.000',1 UNION ALL
select N'IspApp-ui',N'Broadband Internet Provider/ISP Mobile App design concept',N'Design concept for Broadband Internet Provider or ISP. in Xamarin.Forms.',1,1,0,N'XAMARIN',NULL,N'exendahal/Vianet',N'exendahal',2,'2022-10-26 13:47:05.000',1 UNION ALL
select N'link-checker-charts',N'Link Checker Pie Chart',N'A summary of figures using a pie chart made with LiveCharts2. Taken from my work in progress app Link Checker.',1,1,1,N'MAUI',NULL,N'NogginBox/Link-Checker-Samples',N'nogginbox',0,'2022-10-01 10:15:48.000',1 UNION ALL
select N'Listview-Item-Template',N'Listview General Item Template',N'Listview template for displaying item image and details',1,1,0,N'XAMARIN',N'https://github.com/attrib75/ListViewTemplate',N'attrib75/ListViewTemplate',N'attrib75',1,'2020-03-05 04:09:50.000',1 UNION ALL
select N'listview-timeline',N'ListView TimeLine',N'A simple timeline implementation using ListViews with ViewCells, Headers and Footers. But the effect is nice ;-)',1,1,0,N'XAMARIN',N'https://kymphillpotts.com/xamarin-forms-layout-challenges-timeline',N'kphillpotts/XamarinFormsLayoutChallenges',N'kphillpotts',237,'2022-11-09 02:16:20.000',1 UNION ALL
select N'loan-calculator',N'Loan Calculator',N'The Loan Calculator is an application developed using Xamarin.Forms and <a href="https://www.syncfusion.com/xamarin-ui-controls" target="_blank">Syncfusion</a> controls to calculate the EMI with the given details of principal amount, tenure, and interest',1,1,0,N'XAMARIN',N'https://www.syncfusion.com/xamarin-ui-controls',N'syncfusion/xamarin-showcase-emi-calculator',N'syncfusion',65,'2022-11-01 07:16:45.000',1 UNION ALL
select N'Logbook for Vehicle',N'Vehicle Logbook',N'Logbook for collecting all trips',1,1,0,N'MAUI',NULL,N'nehl-it/MauiLogbook',N'dnehl',1,'2022-08-31 10:53:44.000',1 UNION ALL
select N'login-with-imageentry',N'Login with ImageEntry',N'Login UI. NOTE: Check I''m using a custom renderer, the implementation is in the Android/iOS project.',1,1,0,N'XAMARIN',N'https://xamgirl.com/image-entry-in-xamarin-forms',N'CrossGeeks/Xamarin.Forms.UI',N'CrossGeeks',24,'2022-08-01 11:24:14.000',1 UNION ALL
select N'market-growth-strategy',N'Market Growth Strategy',N'Simple replication of this design written in .NET MAUI: https://dribbble.com/shots/19153569-Mobile-App-iOS-Android-UI',1,1,0,N'MAUI',NULL,N'Riccardo11/MarketGrowthStrategy',N'Riccardo11',1,'2022-08-27 18:24:06.000',1 UNION ALL
select N'marvel-cards',N'Marvel Cards',N'A swiping card UI with loads of animations with Skia Sharp.',1,1,0,N'XAMARIN',NULL,N'kphillpotts/MarvelCards',N'kphillpotts',99,'2022-10-22 20:19:05.000',1 UNION ALL
select N'maui-2048-game-clone',N'Maui 2048 Game Clone',N'Cloned version of classic 2048 game built using .NET Maui.',1,1,0,N'MAUI',NULL,N'codeanees/2048Maui',N'codeanees',29,'2022-11-10 19:42:47.000',1 UNION ALL
select N'MauiBlazorWeb',N'Maui Mud Blazor',N'This repo is a Maui Blazor project pre-initalized with MudBlazor UI components with all their styles and layout, this repo helps you get started directly focusing on your code and your logic instead of gettings things ready that''s related to the UI and other stuff.',1,1,0,N'MAUI',NULL,N'kevmoens/MauiBlazorWeb',N'kevmoens',0,'2022-06-07 21:38:37.000',1 UNION ALL
select N'maui-bmi-calc',N'Maui BMI Calculator',N'A simple and gorgeous BMI Calculator built using .NET MAUI and Skia Sharp. Inspired by this Dribble design (https://dribbble.com/shots/7735120-BMI-BMR-Calculator-App-Free-UI-Kit-1-Dribbble-Invitation).',1,1,0,N'MAUI',NULL,N'naweed/MauiBMICalculator',N'naweed',9,'2022-11-05 18:46:01.000',1 UNION ALL
select N'maui-boomerang-card',N'Maui Boomerang Card',N'Boomerang animation in .Net Maui. Inspired by the original Swift UI implementation: https://twitter.com/philipcdavis/status/1534192823792128000',1,1,0,N'MAUI',NULL,N'shawyunz/BoomerangCard.Maui',N'shawyunz',2,'2022-09-06 19:59:14.000',1 UNION ALL
select N'maui-delivery',N'MAUIDelivery',N'A beautiful example of a Delivery App created with a lot of features of .NET MAUI, like shadows, frames, borders, animations, etc.',1,1,0,N'MAUI',N'https://devs.school/how-was-the-mauidelivery-application-created/',N'hprez21/MAUIDelivery',N'hprez21',8,'2022-11-12 00:17:36.000',1 UNION ALL
select N'maui-finance',N'MAUI Finance',N'Finance mobile application UI built in .NET MAUI.',1,1,0,N'MAUI',NULL,N'cemahseri/MauiFinance',N'cemahseri',30,'2022-11-12 06:16:02.000',1 UNION ALL
select N'maui-matching-game',N'Maui Matching Game',N'A simple memory card (match up) game in .Net Maui.',1,1,0,N'MAUI',NULL,N'shawyunz/matching.maui',N'shawyunz',1,'2022-09-09 17:45:39.000',1 UNION ALL
select N'maui-ms-dos',N'Maui MS Dos',N'For all developers who want to make an application with a modern and clean design.',1,1,1,N'MAUI',NULL,N'jm-parent/MSDos4Ever',N'jm-parent',4,'2022-09-12 12:33:13.000',1 UNION ALL
select N'maui-planets',N'Maui Planets',N'This snippet shows Planets Mobile App UI built using .Net Maui. Implements the Dribbble design from https://dribbble.com/shots/15592060-Planet-Mobile-App.',1,1,0,N'MAUI',N'https://blogs.xgenoapps.com/post/2022/07/15/maui-planets-part-2',N'naweed/MauiPlanets',N'naweed',94,'2022-11-16 10:21:33.000',1 UNION ALL
select N'maui-rating-view',N'Rating View Control using Maui.Graphics',N'A simple and customizable Rating View control for use with .NET MAUI Apps. Built using Maui.Graphics.',1,1,1,N'MAUI',N'https://blogs.xgenoapps.com/post/2022/07/03/rating-view-maui',N'naweed/Maui.Controls.RatingView',N'naweed',20,'2022-11-11 21:24:58.000',1 UNION ALL
select N'maui-sci-calc',N'Maui Scientific Calculator',N'This is a complete scientific calculator built using .NET MAUI. Based on the amazing Behance Concept (https://www.behance.net/gallery/79810231/UIUX-Challenge-04-05-Calculator-App-Icon).',1,1,1,N'MAUI',NULL,N'naweed/MauiScientificCalculator',N'naweed',59,'2022-11-08 12:37:33.000',1 UNION ALL
select N'maui-starbucks-redesign',N'Maui Starbuck Redesign',N'StarbucksRedesign App UI build in all new .NET MAUI ',1,0,0,N'MAUI',N'https://github.com/sattasundar/maui-starbucks-ui',N'sattasundar/maui-starbucks-ui',N'sattasundar',29,'2022-11-05 18:46:02.000',1 UNION ALL
select N'maui-tube-player',N'Maui Tube Player',N'A REAL and BEAUTIFUL Youtube Clone app built using .Net Maui.',1,1,1,N'MAUI',N'https://github.com/naweed/MauiTubePlayer',N'naweed/MauiTubePlayer',N'naweed',118,'2022-11-16 17:46:36.000',1 UNION ALL
select N'MbongoUI',N'MbongoUI',N'Developed in Xamarin.Forms to show how we can develop beatiful screens with XamarinForms',1,0,0,N'XAMARIN',NULL,N'Amaro96/MbongoUIApp',N'Amaro96',14,'2021-09-16 13:27:49.000',1 UNION ALL
select N'movie-app',N'Movie App',N'A Xamarin.Forms application based on Movie App - MVP design by Lukáš Straňák and Barbora Sojakova from Dribbble.com.',1,0,0,N'XAMARIN',NULL,N'RadekVyM/Movie-App',N'RadekVyM',5,'2022-09-06 19:51:20.000',1 UNION ALL
select N'music-streaming-stats',N'Music Streaming Stats',N'A simple music streaming stats dashboard app, similar to Spotify for Artists.',1,1,0,N'MAUI',NULL,N'michaldivis/music-streaming-stats-ui',N'michaldivis',1,'2022-08-27 03:05:33.000',1 UNION ALL
select N'netflix-clone',N'Netflix Clone',N'A Xamarin.Forms version of the Netflix App to prove you can create goodlooking UI with Xamarin.Forms.',1,1,0,N'XAMARIN',NULL,N'jsuarezruiz/xamarin-forms-netflix-sample',N'jsuarezruiz',194,'2022-11-05 22:53:14.000',1 UNION ALL
select N'NFTWallet',N'NFT Marketplace',N'Example of an NFT Marketplace. The app brings together cryptocurrency artists, creators and enthusiasts on a single platform to create and trade the best NFTs in a fictitious way. All data displayed in the app is fictitious.',1,1,0,N'XAMARIN',NULL,N'ErickSilva2605/xamarinforms-nft-wallet',N'ErickSilva2605',6,'2022-10-27 19:22:17.000',1 UNION ALL
select N'nubank-clone',N'NuBank Clone',N'NuBank app clone made with Xamarin.Forms 4.3 and CarouselView',1,1,0,N'XAMARIN',NULL,N'felipebaltazar/Xam-Nubank',N'felipebaltazar',20,'2022-07-31 21:47:23.000',1 UNION ALL
select N'nubank-similar-timeline',N'NuBank Similar Timeline',N'Inspired in NuBank app, a simple timeline implementation using ListView with ViewCells and header.

Some details about implementation:

ListView header was made using CarouselView.FormsPlugin to show some informations.
For a better aspect, the fonts was changed to Gotham-Bold and Gotham-Light.
To show correct date time information, was created a converter to parse DateTime object and transform in string.',1,1,0,N'XAMARIN',NULL,N'ionixjunior/xamarin-forms-interfaces',N'ionixjunior',50,'2022-11-11 18:16:41.000',1 UNION ALL
select N'parallax-carousel',N'Parallax Carousel',N'A Xamarin.Forms version of a parallax carousel to prove you can create goodlooking UI with Xamarin.Forms as talked about in my blogpost.',1,1,0,N'XAMARIN',N'https://www.thewissen.io/creating-a-parallax-carousel-in-xamarin-forms',N'sthewissen/KickassUI.ParallaxCarousel',N'sthewissen',118,'2022-09-23 02:39:18.000',1 UNION ALL
select N'Parallax-Effect',N'Parallax Effect',N'The device''s orientation sensor is used to create the parallax effect.',1,1,0,N'XAMARIN',N'https://github.com/ValonK/Xamarin.Forms.Parallax',N'ValonK/Xamarin.Forms.Parallax',N'ValonK',11,'2022-08-02 07:20:48.000',1 UNION ALL
select N'personal-finances-dashboard',N'Personal Finances Dashboard',N'Sample of a dashboard page for a personal finances app with Xamarin.Forms',1,1,0,N'XAMARIN',NULL,N'ricardoprestes/MyDimDim',N'ricardoprestes',20,'2021-12-25 06:36:07.000',1 UNION ALL
select N'picture-download-failed-animation',N'Picture Download Failed Animation',N'This is a sample uses Lottie lib to bring awesome animations to FFImageLoading images lib for Loading indicators and faulted download!! ListView that will download pictures from a URL. While downloading the pictures it will display a loading animation. If download succeeds, it will display and cache the image (FFIMageLoader). If it fails, it will display a failed download animation.',1,1,0,N'XAMARIN',NULL,N'DanielCauser/XamarinFFImageLoadingAndLottie',N'DanielCauser',14,'2020-12-04 13:06:28.000',1 UNION ALL
select N'pin-based-login',N'PIN-based Login',N'This snippet was created to demonstrate a simple PIN-based login screen. It uses buttons and images to create the numpad control. Tapping on a number adds the number to a property bound to the interface. Also contains some simple length checks (max. 6 characters) for the PIN code and uses Fresh MVVM for its page models.',1,1,0,N'XAMARIN',NULL,N'snpptsdev/Snppts.PinBasedLogin',N'sthewissen',6,'2020-05-29 08:01:50.000',1 UNION ALL
select N'places-app-ui',N'Places App UI',N'A Xamarin.Forms Places App Ui.',1,1,0,N'XAMARIN',NULL,N'valentineg8/PlacesApp',N'valentineg8',119,'2022-08-18 23:23:55.000',1 UNION ALL
select N'plantish',N'Plantish - Manage your plants',N'This app was created to easily manage my plants in my house. The idea is to add your plants, provide a watering frequency and when you last gave your plant water. When the plants need water, the app will notify you and you will have to tell the app that you have watered it.',1,0,0,N'XAMARIN',NULL,N'haavamoa/Plantish',N'haavamoa',3,'2020-11-13 09:12:15.000',1 UNION ALL
select N'point-of-sale',N'Point of Sale',N'This snippet shows using .NET MAUI and a variety of community libraries to create a beautiful Point of Sale app suite featuring a desktop/tablet UI and mobile UI.',1,1,1,N'MAUI',NULL,N'dotnet/maui-samples/tree/main/6.0/Apps/PointOfSale',N'davidortinau',0,'2000-01-01 00:00:00.000',0 UNION ALL
select N'poke-app',N'PokeApp',N'This snippet was created to demonstrate some animations and photos',1,1,0,N'XAMARIN',NULL,N'kainaalmeida/pokeapp',N'kainaalmeida',5,'2020-06-21 13:52:29.000',1 UNION ALL
select N'pokedexXF',N'Pokedex XF',N'App developed with XamarinForms to search for pokémons, filtering by types, in addition to viewing more information about the characters.',1,1,0,N'XAMARIN',NULL,N'ErickSilva2605/xamarinforms-pokedex',N'ErickSilva2605',10,'2022-09-09 11:37:27.000',1 UNION ALL
select N'pretty-face-app',N'Pretty Face App',N'This snippet was created to give you a complete starting point for your app.',1,1,0,N'XAMARIN',N'https://www.innovotecnologias.com.ar/',N'InnovoTecnologias/PrettyFaceApp',N'InnovoTecnologias',3,'2022-01-17 05:22:28.000',1 UNION ALL
select N'realestateapp',N'Real Estate App',N'dotnet MAUI UI Sample for Real Estat App',1,1,0,N'MAUI',NULL,N'marcfabregatb/RealEstate.App',N'marcfabregatb',9,'2022-11-03 06:53:05.000',1 UNION ALL
select N'register-with-imageentry',N'Register with ImageEntry',N'SignUp UI. NOTE: Check I''m using a custom renderer, the implementation is in the Android/iOS project.',1,1,0,N'XAMARIN',N'https://xamgirl.com/image-entry-in-xamarin-forms',N'CrossGeeks/Xamarin.Forms.UI',N'CrossGeeks',24,'2022-08-01 11:24:14.000',1 UNION ALL
select N'RunAway!',N'RunAway!',N'Something like a Xamarin.Forms Runtastic-like training sessions viewer, displaying gradient lines on top of Google Maps with SkiaSharp',1,1,1,N'XAMARIN',N'https://www.sharpnado.com/run-away-app/',N'roubachof/SkiaSharpnado',N'roubachof',73,'2022-11-06 01:27:28.000',1 UNION ALL
select N'runkeeper-clone',N'Runkeeper Clone',N'A Xamarin.Forms version of the Runkeeper app to prove you can create goodlooking UI with Xamarin.Forms as talked about in my blogpost.',1,1,0,N'XAMARIN',N'https://www.thewissen.io/xamarin-forms-ui-runkeeper',N'sthewissen/KickassUI.Runkeeper',N'sthewissen',103,'2022-05-28 12:23:20.000',1 UNION ALL
select N'salon-mobile',N'Salon Mobile',N'This snippet was created to demonstrate some animations',1,1,0,N'XAMARIN',NULL,N'kainaalmeida/SalonMobile',N'kainaalmeida',22,'2021-03-15 12:09:51.000',1 UNION ALL
select N'simple-listview-with-cards',N'Simple ListView with Cards',N'A very simple example demonstrating how to create Cards using Xamarin Forms with Xaml.',1,1,0,N'XAMARIN',NULL,N'WashingtonMorais/Xamarin-Forms-Cards',N'WashingtonMorais',10,'2020-03-04 10:43:09.000',1 UNION ALL
select N'simple-login',N'Simple Login',N'A simple login with option to continue as guest.',1,1,0,N'XAMARIN',NULL,N'leijae/SimpleLogin',N'leijae',2,'2020-05-10 17:02:50.000',1 UNION ALL
select N'simple-rating-control-maui',N'Simple Rating Control for .NET MAUI',N'Custom control for .NET MAUI showing a rating using an icon font.',1,1,1,N'MAUI',N'https://github.com/tsjdev-apps/simpleratingcontrol.maui',N'tsjdev-apps/simpleratingcontrol.maui',N'tsjdev-apps',0,'2022-08-03 19:31:44.000',1 UNION ALL
select N'simplest-weather',N'Weather--',N'This is an educational app showcasing a GraphQL Weather API consumed by a Xamarin.Forms app. This repository can be used as a template for a modern Xamarin.Forms 4.3 app with clean and testable architecture consuming a GraphQL endpoint.',1,1,0,N'XAMARIN',N'https://hjerpbakk.com/',N'Sankra/GraphQLDotNet',N'sankra',8,'2022-02-23 22:12:01.000',1 UNION ALL
select N'skia-gauge-chart',N'Skia Gauge Chart',N'Simple gauge chart created with SkiaSharp for Xamarin.Forms',1,1,0,N'XAMARIN',N'https://medium.com/@felipedasilvabaltazar/xamarin-controles-personalizados-com-skiasharp-13ffcfbaa6b6',N'felipebaltazar/CustomCharts',N'felipebaltazar',7,'2022-02-24 18:16:13.000',1 UNION ALL
select N'smart-home-app',N'Smart Home App',N'Xamarin.Forms Challenge recreating Smart Home App UI by Amit kumar',1,1,0,N'XAMARIN',N'https://medium.com/@felipedasilvabaltazar/xamarin-skiasharp-neomorfismo-7127b5e915d7',N'felipebaltazar/NeomorphismSmartHomeApp',N'felipebaltazar',26,'2022-11-11 13:57:28.000',1 UNION ALL
select N'smoothies',N'Smoothies',N'Recently we''ve seen an increase in the amount of smoothies created at the office. Apparently they are the hype object of the month. So without further ado we bring you a sample product overview of smoothies. Yuk! This uses a simple hamburger menu (to counter the health level of these smoothies), a search bar and some custom fonts.',1,1,0,N'XAMARIN',NULL,N'snpptsdev/Snppts.Foodies',N'sthewissen',11,'2019-04-30 05:03:14.000',1 UNION ALL
select N'social-network',N'Social Network',N'A simple Social Network profile type page in Xamarin.Forms.',1,1,1,N'XAMARIN',N'https://kymphillpotts.com/social-network-app-layout-design-in-xamarin-forms',N'kphillpotts/XamarinFormsLayoutChallenges/tree/master/SocialNetwork',N'kphillpotts',0,'2000-01-01 00:00:00.000',0 UNION ALL
select N'soundcloud-clone',N'SoundCloud Clone',N'A clone of the SoundCloud app made with Xamarin.Forms. At moment this app contains the albums, streamings, search and library screens, both in light and dark mode.',1,1,0,N'XAMARIN',N'https://www.youtube.com/playlist?list=PL6M6J_6V_um8IzRN4lgRUEWrPWC6iQfiq',N'ionixjunior/SoundCloudClone',N'ionixjunior',44,'2022-08-26 05:07:58.000',1 UNION ALL
select N'spotify-clone',N'Spotify Clone',N'A Xamarin.Forms version of the Spotify app to prove you can create goodlooking UI with Xamarin.Forms as talked about in my blogpost.',1,1,0,N'XAMARIN',N'https://www.thewissen.io/xamarin-forms-ui-spotify',N'sthewissen/KickassUI.Spotify',N'sthewissen',238,'2022-11-05 19:30:53.000',1 UNION ALL
select N'subscription-plan',N'Subscription Plan',N'A simple subscription plan page',1,1,0,N'XAMARIN',NULL,N'alexandresanlim/XamarinUI.SubscriptionPlan',N'alexandresanlim',1,'2021-07-21 11:03:51.000',1 UNION ALL
select N'tattoo',N'Awesome UI',N'Maui app for tattoo design,Gradient CollectionView!',1,1,0,N'MAUI',NULL,N'umeshkamble/TattooApp',N'umeshkamble',1,'2022-08-30 01:15:46.000',1 UNION ALL
select N'temperature-calculator',N'Temperature Calculator',N'This snippet is a temperature calculator which performs conversion between temperature in Centigrade and Fahrenheit.',1,1,1,N'MAUI',NULL,N'sergy2k/CentiFahrCalc',N'sergy2k',0,'2022-08-26 21:11:22.000',1 UNION ALL
select N'tiktok',N'TikTok Clone',N'TikTok clone build with Xamarin.Forms.',1,0,0,N'XAMARIN',N'https://github.com/ValonK/Xamarin.Forms.TikTok',N'ValonK/Xamarin.Forms.TikTok',N'ValonK',10,'2022-09-22 05:53:18.000',1 UNION ALL
select N'timeline-with-images',N'Timeline With Images',N'Timeline with images in Xamarin.Forms.',1,1,0,N'XAMARIN',N'https://lioncoding.com/2019/04/08/2019-04-08-UI-Concevoir-un-Timeline-dans-Xamarin-Forms/',N'egbakou/Timeline',N'egbakou',33,'2022-11-11 13:57:24.000',1 UNION ALL
select N'todo-app-xamarin-forms',N'Todo App in Xamarin.Forms',N'This snippet was created to demonstrate a well structured Xamarin.Forms MVVM application. It uses feature-based, clean architecture and levarages all built-in MAUI controls.',1,1,0,N'XAMARIN',N'https://github.com/tuyen-vuduc/todo-app-xamarin-forms',N'tuyen-vuduc/todo-app-xamarin-forms',N'tuyen-vuduc',22,'2022-11-16 11:47:22.000',1 UNION ALL
select N'TodoMe',N'Todo.me',N'Todo.me is a simple note taking and task tracking app made with .NET MAUI.',1,0,0,N'MAUI',NULL,N'behl1anmol/Todo.me',N'behl1anmol',5,'2022-11-08 12:52:21.000',1 UNION ALL
select N'traveler',N'Traveler',N'A Xamarin.Forms version of the Traveler app to prove you can create goodlooking UI with Xamarin.Forms as talked about in my blogpost.',1,1,0,N'XAMARIN',N'https://www.thewissen.io/travel-broadens-the-mind',N'sthewissen/KickassUI.Traveler',N'sthewissen',62,'2022-10-02 00:01:56.000',1 UNION ALL
select N'trips',N'Awesome UI - Trips',N'Xamarin Forms iOS Maps, CustomMarkers, Polylines, Clusters and CollectionView!',0,1,0,N'XAMARIN',NULL,N'shanranm/Trips',N'shanranm',4,'2020-03-18 11:13:54.000',1 UNION ALL
select N'twitter-clone',N'Twitter Clone',N'A Xamarin.Forms version of the Twitter app to prove you can create goodlooking UI with Xamarin.Forms as talked about in my blogpost.',1,1,0,N'XAMARIN',N'https://www.thewissen.io/kickass-ui-xamarin-forms-twitter',N'sthewissen/KickassUI.Twitter',N'sthewissen',87,'2022-07-11 02:50:28.000',1 UNION ALL
select N'uber-clone',N'Uber Clone',N'A Xamarin.Forms version of the Uber App to prove you can create goodlooking UI with Xamarin.Forms.',1,1,0,N'XAMARIN',N'https://www.xamboy.com/2019/07/03/introducing-xuber-uber-clone-using-xamarin-forms/',N'CrossGeeks/xUber',N'rdelrosario',219,'2022-11-11 13:56:52.000',1 UNION ALL
select N'ui-app-login',N'UI App Login',N'Simple Login UI. NOTE: Check I''m using an effect for line border entry, the implementation is in the Android/iOS project.',1,1,0,N'XAMARIN',NULL,N'CrossGeeks/Xamarin.Forms.UI',N'CrossGeeks',24,'2022-08-01 11:24:14.000',1 UNION ALL
select N'voucher',N'Voucher',N'It''s a voucher list sample',1,1,0,N'XAMARIN',NULL,N'AlexandreSanlim/XamarinUI.Voucher',N'alexandresanlim',3,'2020-08-06 12:37:08.000',1 UNION ALL
select N'waste-app',N'Waste App',N'A Xamarin.Forms application based on Waste App design by Sara Salehi from Dribbble.com.',1,0,0,N'XAMARIN',NULL,N'RadekVyM/Waste-App',N'RadekVyM',8,'2022-09-06 19:51:10.000',1 UNION ALL
select N'weather-app-ui',N'Weather App UI',N'A Xamarin.Forms Weather App Ui.',1,1,0,N'XAMARIN',NULL,N'valentineg8/WeatherApp',N'valentineg8',39,'2022-02-16 14:40:26.000',1 UNION ALL
select N'weather-xam',N'Weather',N'A Xamarin.Forms weather app with beautiful UI based on Samsung and Huawei weather apps.',1,0,0,N'XAMARIN',NULL,N'aizendong/WeatherXam',N'AizenDong',2,'2022-08-31 01:51:16.000',1 UNION ALL
select N'welcome-page',N'Welcome Page',N'Example of a welcome page with Xamarin.Forms.',1,1,0,N'XAMARIN',NULL,N'TBertuzzi/PaginaIIntroducaoExemplo',N'TBertuzzi',5,'2020-04-22 20:57:40.000',1 UNION ALL
select N'welcome-pages',N'Welcome Pages',N'Template app with a few unused Welcome Pages. I''m also using Carousel on a few pages. And yes the text is slidable.',1,1,0,N'XAMARIN',NULL,N'leroygumede/WelcomeCarousel',N'leroygumede',1,'2018-05-22 10:39:36.000',1 UNION ALL
select N'whatsapp-chat-list',N'WhatsApp Chat List',N'Inspired in WhatsApp, a simple chat list implementation using ListView with ViewCells. Some details about implementation: ListView was made with DataTemplateSelector for single messages and group messages. Rounded images use FFImageLoading with circle transformation. For iOS, a render for ViewCell was made for add cell accessory and make margin adjustments in separator inset. To show correct colours of the badges, was created color in resource dictionary with different values for each platform. To show correct date time information, was created a converter to parse DateTime object and transform in string.',1,1,0,N'XAMARIN',NULL,N'ionixjunior/xamarin-forms-interfaces',N'ionixjunior',50,'2022-11-11 18:16:41.000',1 UNION ALL
select N'whatsapp-ui',N'WhatsApp UI Clone',N'WhatsApp UI Clone in Xamarin.Forms.',1,1,0,N'XAMARIN',N'https://lioncoding.com/2019/05/08/2019-05-08-whatsapp-ui-dans-xamarin-forms-partie-1/',N'egbakou/WhatsAppUI',N'egbakou',285,'2022-11-11 19:45:49.000',1 UNION ALL
select N'xamarinforms-ecommerce-headphones',N'Xamarin.Forms Headphones e-commerce concept',N'Headset e-commerce concept developed at Xamarin.Forms',1,1,0,N'XAMARIN',NULL,N'Altevir/xamarinforms-ecommerce-headphones',N'Altevir',17,'2022-05-06 11:25:53.000',1 UNION ALL
select N'XamarinForms-PhotoStock-UI-Design',N'Xamarin.Forms PhotoStock UI Design',N'Xamarin.Forms photo stock application design.',1,1,0,N'XAMARIN',NULL,N'ufukhawk/XamarinForms-PhotoStock-UI-Design',N'ufukhawk',25,'2022-11-06 13:44:20.000',1 UNION ALL
select N'xamarinforms-wallet-creditcard',N'XanarinForms Wallet Credit Card',N'Concept of Wallet Credit Card App developed with Xamarin.Forms.',1,1,0,N'XAMARIN',NULL,N'Altevir/xamarinforms-wallet-creditcard',N'Altevir',35,'2021-09-16 13:25:45.000',1 UNION ALL
select N'xam-book-library',N'Awesome UI - Book Library',N'Neat Xamarin.Forms UI with simple animation',1,1,0,N'XAMARIN',NULL,N'shanranm/XamBookLibrary',N'shanranm',45,'2022-11-11 13:57:15.000',1 UNION ALL
select N'Xam-Call',N'XamCall',N'Xamarin Forms Call Screen UI Design',1,1,0,N'XAMARIN',NULL,N'ufukhawk/XamCall',N'ufukhawk',25,'2022-04-22 05:36:34.000',1 UNION ALL
select N'Xam-Login-UI-Demo',N'XamLogin UI Demo',N'Xamarin.Forms Login UI',1,1,0,N'XAMARIN',NULL,N'ufukhawk/XamUIDemo',N'ufukhawk',111,'2022-11-14 01:39:20.000',1 UNION ALL
select N'xam-translator',N'Xam Translator',N'This snippet was created to reproduce an Dictionary/Translator App using some Material design components.',1,1,0,N'XAMARIN',N'https://github.com/aimore/XamUI/tree/master/XFTranslator',N'aimore/XamUI',N'aimore',58,'2022-08-17 00:04:35.000',1 UNION ALL
select N'xf-games-chips',N'XF Games Chips',N'Example project to show how to create so-called ''Chips'' (without a plugin), used for data filtering, etc.',1,1,0,N'XAMARIN',NULL,N'Altevir/xamarinforms-games-chips',N'Altevir',13,'2020-06-22 12:04:30.000',1;
GO
insert [Snippet_Category] ([Slug],[Category])
select N'bottomappbar-material',N'DASHBOARD' UNION ALL
select N'bottomappbar-material',N'NAVIGATIONS' UNION ALL
select N'health-tracker',N'DASHBOARD' UNION ALL
select N'health-tracker',N'LISTS' UNION ALL
select N'point-of-sale',N'STORES' UNION ALL
select N'maui-starbucks-redesign',N'PRODUCTS' UNION ALL
select N'xam-translator',N'CARDS' UNION ALL
select N'addcreditcard',N'SHOPPINGCART' UNION ALL
select N'addcreditcard',N'STORES' UNION ALL
select N'addtoshoppingcart',N'SHOPPINGCART' UNION ALL
select N'addtoshoppingcart',N'STORES' UNION ALL
select N'art-auction',N'CARDS' UNION ALL
select N'art-auction',N'LISTS' UNION ALL
select N'art-auction',N'POPOVERS' UNION ALL
select N'avatar login',N'LOGIN' UNION ALL
select N'band-tracker',N'CARDS' UNION ALL
select N'band-tracker',N'DASHBOARD' UNION ALL
select N'band-tracker',N'FILTER' UNION ALL
select N'band-tracker',N'LISTS' UNION ALL
select N'band-tracker',N'PROFILES' UNION ALL
select N'band-tracker',N'TABBARS' UNION ALL
select N'bet-app',N'CALENDARSTIME' UNION ALL
select N'bet-app',N'CARDS' UNION ALL
select N'bet-app',N'LISTS' UNION ALL
select N'bet-app',N'NAVIGATIONS' UNION ALL
select N'maui-boomerang-card',N'ARTICLES' UNION ALL
select N'maui-boomerang-card',N'CARDS' UNION ALL
select N'maui-boomerang-card',N'WIDGETS' UNION ALL
select N'breadcrumb-control',N'NAVIGATIONS' UNION ALL
select N'breadcrumb-control',N'SIDEBARS' UNION ALL
select N'calling-app',N'CARDS' UNION ALL
select N'calling-app',N'LISTS' UNION ALL
select N'calling-app',N'NAVIGATIONS' UNION ALL
select N'carousel-essentials',N'CARDS' UNION ALL
select N'carousel-essentials',N'CAROUSEL' UNION ALL
select N'carousel-intro-page',N'LOGIN' UNION ALL
select N'chameleon',N'CARDS' UNION ALL
select N'chameleon',N'PHOTOS' UNION ALL
select N'Chased-Home-UI-Design',N'DASHBOARD' UNION ALL
select N'Chased-Home-UI-Design',N'LISTS' UNION ALL
select N'Chased-Home-UI-Design',N'LOGIN' UNION ALL
select N'Chased-Home-UI-Design',N'NAVIGATIONS' UNION ALL
select N'Chased-Home-UI-Design',N'PHOTOS' UNION ALL
select N'Chased-Home-UI-Design',N'PROFILES' UNION ALL
select N'Chased-Home-UI-Design',N'SEARCH' UNION ALL
select N'Chased-Home-UI-Design',N'SIGNUPS' UNION ALL
select N'chick-and-paddy-dotnet-maui',N'ACTIVITYFEEDS' UNION ALL
select N'chick-and-paddy-dotnet-maui',N'LOGIN' UNION ALL
select N'chick-and-paddy-dotnet-maui',N'NAVIGATIONS' UNION ALL
select N'chick-and-paddy-dotnet-maui',N'SETTINGS' UNION ALL
select N'chick-and-paddy-dotnet-maui',N'SHARE' UNION ALL
select N'chick-and-paddy-dotnet-maui',N'SIGNUPS' UNION ALL
select N'chick-and-paddy-dotnet-maui',N'SOCIALNETWORK' UNION ALL
select N'chick-and-paddy-dotnet-maui',N'WALKTHROUGHS' UNION ALL
select N'concentric-onboarding',N'DASHBOARD' UNION ALL
select N'concentric-onboarding',N'WIDGETS' UNION ALL
select N'covid19-live',N'DASHBOARD' UNION ALL
select N'covid19-live',N'FILTER' UNION ALL
select N'covid19-live',N'LISTS' UNION ALL
select N'covid19-live',N'PHOTOS' UNION ALL
select N'covid19-live',N'SEARCH' UNION ALL
select N'covid19-live',N'SETTINGS' UNION ALL
select N'covid19-tracker-ui',N'CARDS' UNION ALL
select N'covid19-tracker-ui',N'FRIENDS' UNION ALL
select N'CovidTrack',N'FILTER' UNION ALL
select N'CovidTrack',N'LAUNCHSCREEN' UNION ALL
select N'CovidTrack',N'LISTS' UNION ALL
select N'CovidTrack',N'WIDGETS' UNION ALL
select N'credit-card-checkout',N'CARDS' UNION ALL
select N'credit-card-checkout',N'SHOPPINGCART' UNION ALL
select N'credit-card-checkout',N'TIMELINE' UNION ALL
select N'credit-card-payment-ui',N'CARDS' UNION ALL
select N'credit-card-payment-ui',N'NAVIGATIONS' UNION ALL
select N'credit-card-payment-ui',N'WALKTHROUGHS' UNION ALL
select N'cruise-mobile-ui',N'LISTS' UNION ALL
select N'cruise-mobile-ui',N'PRODUCTS' UNION ALL
select N'Dark-Store',N'CARDS' UNION ALL
select N'Dark-Store',N'DASHBOARD' UNION ALL
select N'Dark-Store',N'LISTS' UNION ALL
select N'Dark-Store',N'NAVIGATIONS' UNION ALL
select N'Dark-Store',N'PHOTOS' UNION ALL
select N'Dark-Store',N'PROFILES' UNION ALL
select N'Dark-Store',N'STORES' UNION ALL
select N'dashboard-drawer',N'CARDS' UNION ALL
select N'dashboard-drawer',N'DASHBOARD' UNION ALL
select N'day-vs-night',N'DASHBOARD' UNION ALL
select N'day-vs-night',N'PROFILES' UNION ALL
select N'day-vs-night',N'WIDGETS' UNION ALL
select N'discover-gists',N'CARDS' UNION ALL
select N'discover-gists',N'LISTS' UNION ALL
select N'discover-gists',N'SOCIALNETWORK' UNION ALL
select N'duolingo-clone',N'APPCLONE' UNION ALL
select N'duolingo-clone',N'DASHBOARD' UNION ALL
select N'duolingo-clone',N'LISTS' UNION ALL
select N'duolingo-clone',N'TABBARS' UNION ALL
select N'EcommerceUI',N'DASHBOARD' UNION ALL
select N'EcommerceUI',N'LISTS' UNION ALL
select N'EcommerceUI',N'SHOPPINGCART' UNION ALL
select N'EcommerceUI',N'TABBARS' UNION ALL
select N'Enlighten',N'ARTICLES' UNION ALL
select N'Enlighten',N'LISTS' UNION ALL
select N'Enlighten',N'LOGIN' UNION ALL
select N'Enlighten',N'MESSAGING' UNION ALL
select N'Enlighten',N'SIGNUPS' UNION ALL
select N'essential-ui-kit',N'ABOUT' UNION ALL
select N'essential-ui-kit',N'ARTICLES' UNION ALL
select N'essential-ui-kit',N'ERRORS' UNION ALL
select N'essential-ui-kit',N'LAUNCHSCREEN' UNION ALL
select N'essential-ui-kit',N'LOGIN' UNION ALL
select N'essential-ui-kit',N'MESSAGING' UNION ALL
select N'essential-ui-kit',N'NAVIGATIONS' UNION ALL
select N'essential-ui-kit',N'PRODUCTS' UNION ALL
select N'essential-ui-kit',N'PROFILES' UNION ALL
select N'essential-ui-kit',N'SIGNUPS' UNION ALL
select N'essential-ui-kit',N'WALKTHROUGHS' UNION ALL
select N'f1tv',N'APPCLONE' UNION ALL
select N'f1tv',N'CAROUSEL' UNION ALL
select N'facebook-mobile-app-login-ui-clone',N'LOGIN' UNION ALL
select N'fancy-tutorial',N'PHOTOS' UNION ALL
select N'fancy-tutorial',N'WALKTHROUGHS' UNION ALL
select N'fashion-store-ui',N'LISTS' UNION ALL
select N'fashion-store-ui',N'STORES' UNION ALL
select N'maui-finance',N'CARDS' UNION ALL
select N'maui-finance',N'DASHBOARD' UNION ALL
select N'maui-finance',N'DATAGRID' UNION ALL
select N'foodapp',N'CARDS' UNION ALL
select N'foodapp',N'PHOTOS' UNION ALL
select N'foodapp',N'PRODUCTS' UNION ALL
select N'foodapp',N'PROFILES' UNION ALL
select N'four-seasons',N'CARDS' UNION ALL
select N'four-seasons',N'CHARTS' UNION ALL
select N'four-seasons',N'LISTS' UNION ALL
select N'four-seasons',N'NAVIGATIONS' UNION ALL
select N'four-seasons',N'TABBARS' UNION ALL
select N'Chat app UI',N'FRIENDS' UNION ALL
select N'Chat app UI',N'MESSAGING' UNION ALL
select N'Chat app UI',N'SOCIALNETWORK' UNION ALL
select N'gadgets-store-app',N'CARDS' UNION ALL
select N'gadgets-store-app',N'LISTS' UNION ALL
select N'gadgets-store-app',N'NAVIGATIONS' UNION ALL
select N'gadgets-store-app',N'PRODUCTS' UNION ALL
select N'xf-games-chips',N'LISTS' UNION ALL
select N'xf-games-chips',N'PHOTOS' UNION ALL
select N'great-places',N'LISTS' UNION ALL
select N'great-places',N'PHOTOS' UNION ALL
select N'homemadefood',N'CAROUSEL' UNION ALL
select N'homemadefood',N'FILTER' UNION ALL
select N'homemadefood',N'NAVIGATIONS' UNION ALL
select N'im-feeling-lucky',N'CARDS' UNION ALL
select N'in-space',N'CALCULATORS' UNION ALL
select N'in-space',N'CARDS' UNION ALL
select N'initials-view',N'WIDGETS' UNION ALL
select N'IspApp-ui',N'DASHBOARD' UNION ALL
select N'IspApp-ui',N'LISTS' UNION ALL
select N'IspApp-ui',N'LOGIN' UNION ALL
select N'IspApp-ui',N'TABBARS' UNION ALL
select N'IspApp-ui',N'WIDGETS' UNION ALL
select N'link-checker-charts',N'CHARTS' UNION ALL
select N'Listview-Item-Template',N'LISTS' UNION ALL
select N'listview-timeline',N'ACTIVITYFEEDS' UNION ALL
select N'listview-timeline',N'LISTS' UNION ALL
select N'listview-timeline',N'TIMELINE' UNION ALL
select N'loan-calculator',N'CALCULATORS' UNION ALL
select N'loan-calculator',N'CHARTS' UNION ALL
select N'loan-calculator',N'DATAGRID' UNION ALL
select N'login-with-imageentry',N'LOGIN' UNION ALL
select N'maui-delivery',N'STORES' UNION ALL
select N'market-growth-strategy',N'DASHBOARD' UNION ALL
select N'market-growth-strategy',N'PROFILES' UNION ALL
select N'marvel-cards',N'CARDS' UNION ALL
select N'marvel-cards',N'LISTS' UNION ALL
select N'marvel-cards',N'NAVIGATIONS' UNION ALL
select N'marvel-cards',N'POPOVERS' UNION ALL
select N'maui-matching-game',N'CARDS' UNION ALL
select N'maui-matching-game',N'WIDGETS' UNION ALL
select N'maui-2048-game-clone',N'APPCLONE' UNION ALL
select N'maui-bmi-calc',N'CALCULATORS' UNION ALL
select N'dotnet-maui-bank',N'APPCLONE' UNION ALL
select N'dotnet-maui-bank',N'CARDS' UNION ALL
select N'dotnet-maui-bank',N'LOGIN' UNION ALL
select N'dotnet-maui-bank',N'SHOPPINGCART' UNION ALL
select N'Logbook for Vehicle',N'CARDS' UNION ALL
select N'Logbook for Vehicle',N'PROFILES' UNION ALL
select N'maui-ms-dos',N'CARDS' UNION ALL
select N'maui-ms-dos',N'LAUNCHSCREEN' UNION ALL
select N'MauiBlazorWeb',N'DATAGRID' UNION ALL
select N'MauiBlazorWeb',N'SIDEBARS' UNION ALL
select N'maui-planets',N'APPCLONE' UNION ALL
select N'maui-rating-view',N'WIDGETS' UNION ALL
select N'maui-sci-calc',N'CALCULATORS' UNION ALL
select N'maui-tube-player',N'APPCLONE' UNION ALL
select N'maui-tube-player',N'PLAYBACK' UNION ALL
select N'maui-tube-player',N'SOCIALNETWORK' UNION ALL
select N'MbongoUI',N'LAUNCHSCREEN' UNION ALL
select N'MbongoUI',N'LISTS' UNION ALL
select N'MbongoUI',N'WIDGETS' UNION ALL
select N'movie-app',N'CARDS' UNION ALL
select N'movie-app',N'CAROUSEL' UNION ALL
select N'movie-app',N'LISTS' UNION ALL
select N'movie-app',N'NAVIGATIONS' UNION ALL
select N'movie-app',N'PHOTOS' UNION ALL
select N'music-streaming-stats',N'DASHBOARD' UNION ALL
select N'NFTWallet',N'CARDS' UNION ALL
select N'NFTWallet',N'CHARTS' UNION ALL
select N'NFTWallet',N'FILTER' UNION ALL
select N'NFTWallet',N'LISTS' UNION ALL
select N'NFTWallet',N'LOGIN' UNION ALL
select N'NFTWallet',N'PHOTOS' UNION ALL
select N'NFTWallet',N'PROFILES' UNION ALL
select N'NFTWallet',N'SEARCH' UNION ALL
select N'NFTWallet',N'SETTINGS' UNION ALL
select N'NFTWallet',N'TABBARS' UNION ALL
select N'netflix-clone',N'APPCLONE' UNION ALL
select N'netflix-clone',N'LISTS' UNION ALL
select N'netflix-clone',N'NAVIGATIONS' UNION ALL
select N'netflix-clone',N'WIDGETS' UNION ALL
select N'nubank-clone',N'APPCLONE' UNION ALL
select N'nubank-clone',N'CARDS' UNION ALL
select N'nubank-clone',N'DASHBOARD' UNION ALL
select N'nubank-clone',N'WIDGETS' UNION ALL
select N'nubank-similar-timeline',N'TIMELINE' UNION ALL
select N'parallax-carousel',N'CARDS' UNION ALL
select N'parallax-carousel',N'WALKTHROUGHS' UNION ALL
select N'Parallax-Effect',N'CARDS' UNION ALL
select N'Parallax-Effect',N'CAROUSEL' UNION ALL
select N'personal-finances-dashboard',N'CHARTS' UNION ALL
select N'personal-finances-dashboard',N'DASHBOARD' UNION ALL
select N'personal-finances-dashboard',N'WIDGETS' UNION ALL
select N'picture-download-failed-animation',N'LISTS' UNION ALL
select N'picture-download-failed-animation',N'PHOTOS' UNION ALL
select N'pin-based-login',N'LOGIN' UNION ALL
select N'places-app-ui',N'LISTS' UNION ALL
select N'plantish',N'DASHBOARD' UNION ALL
select N'plantish',N'LAUNCHSCREEN' UNION ALL
select N'plantish',N'LISTS' UNION ALL
select N'plantish',N'NOTIFICATIONS' UNION ALL
select N'plantish',N'PHOTOS' UNION ALL
select N'poke-app',N'CARDS' UNION ALL
select N'poke-app',N'LISTS' UNION ALL
select N'poke-app',N'PHOTOS' UNION ALL
select N'pokedexXF',N'CARDS' UNION ALL
select N'pokedexXF',N'FILTER' UNION ALL
select N'pokedexXF',N'LAUNCHSCREEN' UNION ALL
select N'pokedexXF',N'LISTS' UNION ALL
select N'pokedexXF',N'PHOTOS' UNION ALL
select N'pokedexXF',N'SEARCH' UNION ALL
select N'pokedexXF',N'TABBARS' UNION ALL
select N'pretty-face-app',N'CARDS' UNION ALL
select N'pretty-face-app',N'DASHBOARD' UNION ALL
select N'pretty-face-app',N'LAUNCHSCREEN' UNION ALL
select N'pretty-face-app',N'LISTS' UNION ALL
select N'pretty-face-app',N'NAVIGATIONS' UNION ALL
select N'realestateapp',N'APPCLONE' UNION ALL
select N'realestateapp',N'CAROUSEL' UNION ALL
select N'realestateapp',N'LISTS' UNION ALL
select N'realestateapp',N'STORES' UNION ALL
select N'register-with-imageentry',N'SIGNUPS' UNION ALL
select N'RunAway!',N'CARDS' UNION ALL
select N'RunAway!',N'MAPS' UNION ALL
select N'runkeeper-clone',N'APPCLONE' UNION ALL
select N'runkeeper-clone',N'DASHBOARD' UNION ALL
select N'runkeeper-clone',N'MAPS' UNION ALL
select N'runkeeper-clone',N'NAVIGATIONS' UNION ALL
select N'salon-mobile',N'LISTS' UNION ALL
select N'salon-mobile',N'PHOTOS' UNION ALL
select N'simple-listview-with-cards',N'CARDS' UNION ALL
select N'simple-listview-with-cards',N'LISTS' UNION ALL
select N'simple-login',N'LOGIN' UNION ALL
select N'simple-rating-control-maui',N'CHARTS' UNION ALL
select N'simple-rating-control-maui',N'WIDGETS' UNION ALL
select N'simplest-weather',N'APPCLONE' UNION ALL
select N'simplest-weather',N'DATAGRID' UNION ALL
select N'simplest-weather',N'FILTER' UNION ALL
select N'simplest-weather',N'LISTS' UNION ALL
select N'simplest-weather',N'TABBARS' UNION ALL
select N'skia-gauge-chart',N'CARDS' UNION ALL
select N'skia-gauge-chart',N'CHARTS' UNION ALL
select N'skia-gauge-chart',N'DASHBOARD' UNION ALL
select N'skia-gauge-chart',N'WIDGETS' UNION ALL
select N'smart-home-app',N'ARTICLES' UNION ALL
select N'smart-home-app',N'DASHBOARD' UNION ALL
select N'smart-home-app',N'NEOMORPHISM' UNION ALL
select N'smart-home-app',N'WIDGETS' UNION ALL
select N'smoothies',N'CARDS' UNION ALL
select N'smoothies',N'LISTS' UNION ALL
select N'smoothies',N'PRODUCTS' UNION ALL
select N'social-network',N'ABOUT' UNION ALL
select N'social-network',N'FRIENDS' UNION ALL
select N'social-network',N'PHOTOS' UNION ALL
select N'soundcloud-clone',N'ACTIVITYFEEDS' UNION ALL
select N'soundcloud-clone',N'APPCLONE' UNION ALL
select N'soundcloud-clone',N'LISTS' UNION ALL
select N'soundcloud-clone',N'SEARCH' UNION ALL
select N'soundcloud-clone',N'TABBARS' UNION ALL
select N'spotify-clone',N'APPCLONE' UNION ALL
select N'spotify-clone',N'DASHBOARD' UNION ALL
select N'spotify-clone',N'LISTS' UNION ALL
select N'spotify-clone',N'PLAYBACK' UNION ALL
select N'subscription-plan',N'CARDS' UNION ALL
select N'subscription-plan',N'CAROUSEL' UNION ALL
select N'subscription-plan',N'LISTS' UNION ALL
select N'tattoo',N'FRIENDS' UNION ALL
select N'tattoo',N'SOCIALNETWORK' UNION ALL
select N'temperature-calculator',N'CALCULATORS' UNION ALL
select N'tiktok',N'CAROUSEL' UNION ALL
select N'timeline-with-images',N'LISTS' UNION ALL
select N'timeline-with-images',N'PHOTOS' UNION ALL
select N'timeline-with-images',N'TIMELINE' UNION ALL
select N'todo-app-xamarin-forms',N'CHARTS' UNION ALL
select N'todo-app-xamarin-forms',N'DASHBOARD' UNION ALL
select N'todo-app-xamarin-forms',N'LISTS' UNION ALL
select N'todo-app-xamarin-forms',N'NAVIGATIONS' UNION ALL
select N'todo-app-xamarin-forms',N'SIDEBARS' UNION ALL
select N'TodoMe',N'ACTIVITYFEEDS' UNION ALL
select N'TodoMe',N'LISTS' UNION ALL
select N'TodoMe',N'NAVIGATIONS' UNION ALL
select N'traveler',N'CARDS' UNION ALL
select N'traveler',N'DASHBOARD' UNION ALL
select N'traveler',N'LISTS' UNION ALL
select N'trips',N'MAPS' UNION ALL
select N'trips',N'NAVIGATIONS' UNION ALL
select N'twitter-clone',N'ACTIVITYFEEDS' UNION ALL
select N'twitter-clone',N'APPCLONE' UNION ALL
select N'twitter-clone',N'NAVIGATIONS' UNION ALL
select N'twitter-clone',N'SIDEBARS' UNION ALL
select N'ui-app-login',N'LOGIN' UNION ALL
select N'uber-clone',N'APPCLONE' UNION ALL
select N'uber-clone',N'MAPS' UNION ALL
select N'uber-clone',N'SEARCH' UNION ALL
select N'uber-clone',N'WIDGETS' UNION ALL
select N'voucher',N'CARDS' UNION ALL
select N'voucher',N'STORES' UNION ALL
select N'xamarinforms-wallet-creditcard',N'CARDS' UNION ALL
select N'xamarinforms-wallet-creditcard',N'LISTS' UNION ALL
select N'xamarinforms-wallet-creditcard',N'PHOTOS' UNION ALL
select N'xamarinforms-wallet-creditcard',N'SEARCH' UNION ALL
select N'xamarinforms-wallet-creditcard',N'STORES' UNION ALL
select N'waste-app',N'CARDS' UNION ALL
select N'waste-app',N'LISTS' UNION ALL
select N'waste-app',N'NAVIGATIONS' UNION ALL
select N'waste-app',N'PHOTOS' UNION ALL
select N'weather-app-ui',N'DASHBOARD' UNION ALL
select N'weather-xam',N'APPCLONE' UNION ALL
select N'weather-xam',N'CARDS' UNION ALL
select N'weather-xam',N'CHARTS' UNION ALL
select N'weather-xam',N'DASHBOARD' UNION ALL
select N'weather-xam',N'DATAGRID' UNION ALL
select N'weather-xam',N'LAUNCHSCREEN' UNION ALL
select N'weather-xam',N'NAVIGATIONS' UNION ALL
select N'weather-xam',N'SEARCH' UNION ALL
select N'weather-xam',N'SETTINGS' UNION ALL
select N'welcome-page',N'LOGIN' UNION ALL
select N'welcome-pages',N'WALKTHROUGHS' UNION ALL
select N'whatsapp-chat-list',N'MESSAGING' UNION ALL
select N'whatsapp-ui',N'FRIENDS' UNION ALL
select N'whatsapp-ui',N'LISTS' UNION ALL
select N'whatsapp-ui',N'MESSAGING' UNION ALL
select N'whatsapp-ui',N'PHOTOS' UNION ALL
select N'xamarinforms-ecommerce-headphones',N'CARDS' UNION ALL
select N'xamarinforms-ecommerce-headphones',N'LISTS' UNION ALL
select N'xamarinforms-ecommerce-headphones',N'PHOTOS' UNION ALL
select N'xamarinforms-ecommerce-headphones',N'PRODUCTS' UNION ALL
select N'xamarinforms-ecommerce-headphones',N'SEARCH' UNION ALL
select N'XamarinForms-PhotoStock-UI-Design',N'DASHBOARD' UNION ALL
select N'XamarinForms-PhotoStock-UI-Design',N'FILTER' UNION ALL
select N'XamarinForms-PhotoStock-UI-Design',N'LISTS' UNION ALL
select N'XamarinForms-PhotoStock-UI-Design',N'PHOTOS' UNION ALL
select N'XamarinForms-PhotoStock-UI-Design',N'SEARCH' UNION ALL
select N'XamarinForms-PhotoStock-UI-Design',N'SETTINGS' UNION ALL
select N'xam-book-library',N'CARDS' UNION ALL
select N'xam-book-library',N'NAVIGATIONS' UNION ALL
select N'Xam-Call',N'DASHBOARD' UNION ALL
select N'Xam-Call',N'NAVIGATIONS' UNION ALL
select N'Xam-Call',N'PHOTOS' UNION ALL
select N'Xam-Call',N'PROFILES' UNION ALL
select N'Xam-Login-UI-Demo',N'DASHBOARD' UNION ALL
select N'Xam-Login-UI-Demo',N'LOGIN' UNION ALL
select N'Xam-Login-UI-Demo',N'NAVIGATIONS' UNION ALL
select N'Xam-Login-UI-Demo',N'PHOTOS' UNION ALL
select N'Xam-Login-UI-Demo',N'PROFILES' UNION ALL
select N'Xam-Login-UI-Demo',N'SIGNUPS';
GO
insert [Snippet_Image] ([Slug],[ImageUri])
select N'bottomappbar-material',N'https://i.imgur.com/dXDg9xF.png' UNION ALL
select N'bottomappbar-material',N'https://i.imgur.com/Q8cuoVf.png' UNION ALL
select N'health-tracker',N'https://user-images.githubusercontent.com/39446369/184413816-0daa94aa-83bb-42ea-af9c-4e1f855f7122.png' UNION ALL
select N'health-tracker',N'https://user-images.githubusercontent.com/39446369/184413930-5a93a13d-e1d4-4d0b-9874-67f7065f4f26.png' UNION ALL
select N'point-of-sale',N'https://user-images.githubusercontent.com/41873/183739194-0e19cb9c-71aa-490b-9e80-25ea1dc40ce0.png' UNION ALL
select N'point-of-sale',N'https://user-images.githubusercontent.com/41873/183740348-7f55d10d-8f79-4ee0-a71e-64b317cbd64f.png' UNION ALL
select N'maui-starbucks-redesign',N'https://raw.githubusercontent.com/sattasundar/maui-starbucks-ui/main/images/android_detail.png' UNION ALL
select N'maui-starbucks-redesign',N'https://raw.githubusercontent.com/sattasundar/maui-starbucks-ui/main/images/android_home.png' UNION ALL
select N'maui-starbucks-redesign',N'https://raw.githubusercontent.com/sattasundar/maui-starbucks-ui/main/images/android_splash.png' UNION ALL
select N'maui-starbucks-redesign',N'https://raw.githubusercontent.com/sattasundar/maui-starbucks-ui/main/images/ios_detail.png' UNION ALL
select N'maui-starbucks-redesign',N'https://raw.githubusercontent.com/sattasundar/maui-starbucks-ui/main/images/ios_home.png' UNION ALL
select N'maui-starbucks-redesign',N'https://raw.githubusercontent.com/sattasundar/maui-starbucks-ui/main/images/mac_detail.png' UNION ALL
select N'maui-starbucks-redesign',N'https://raw.githubusercontent.com/sattasundar/maui-starbucks-ui/main/images/mac_home.png' UNION ALL
select N'xam-translator',N'https://i.imgur.com/E7rpRav.png' UNION ALL
select N'xam-translator',N'https://i.imgur.com/o2ATjel.png' UNION ALL
select N'addcreditcard',N'https://raw.githubusercontent.com/alexandresanlim/XamarinUI.AddCreditCard/master/XamarinUI.AddCreditCard/XamarinUI.AddCreditCard/src/screenshot/android.gif' UNION ALL
select N'addcreditcard',N'https://raw.githubusercontent.com/alexandresanlim/XamarinUI.AddCreditCard/master/XamarinUI.AddCreditCard/XamarinUI.AddCreditCard/src/screenshot/iosback.png' UNION ALL
select N'addcreditcard',N'https://raw.githubusercontent.com/alexandresanlim/XamarinUI.AddCreditCard/master/XamarinUI.AddCreditCard/XamarinUI.AddCreditCard/src/screenshot/iosfront.png' UNION ALL
select N'addtoshoppingcart',N'https://github.com/alexandresanlim/XamarinUI.AddToShoppingCart/raw/master/XamarinUI.AddToShoppingCard/XamarinUI.AddToShoppingCard/Src/img/screen/gif.gif?raw=true' UNION ALL
select N'addtoshoppingcart',N'https://github.com/alexandresanlim/XamarinUI.AddToShoppingCart/raw/master/XamarinUI.AddToShoppingCard/XamarinUI.AddToShoppingCard/Src/img/screen/ios/not1.png?raw=true' UNION ALL
select N'addtoshoppingcart',N'https://github.com/alexandresanlim/XamarinUI.AddToShoppingCart/raw/master/XamarinUI.AddToShoppingCard/XamarinUI.AddToShoppingCard/Src/img/screen/ios/not2.png?raw=true' UNION ALL
select N'addtoshoppingcart',N'https://github.com/alexandresanlim/XamarinUI.AddToShoppingCart/raw/master/XamarinUI.AddToShoppingCard/XamarinUI.AddToShoppingCard/Src/img/screen/ios/not3.png?raw=true' UNION ALL
select N'addtoshoppingcart',N'https://github.com/alexandresanlim/XamarinUI.AddToShoppingCart/raw/master/XamarinUI.AddToShoppingCard/XamarinUI.AddToShoppingCard/Src/img/screen/ios/not4.png?raw=true' UNION ALL
select N'addtoshoppingcart',N'https://github.com/alexandresanlim/XamarinUI.AddToShoppingCart/raw/master/XamarinUI.AddToShoppingCard/XamarinUI.AddToShoppingCard/Src/img/screen/ios/not5.png?raw=true' UNION ALL
select N'art-auction',N'https://kymphillpotts.com/assets/images/posts/artauction-screen1.png' UNION ALL
select N'art-auction',N'https://kymphillpotts.com/assets/images/posts/artauction-screen2.png' UNION ALL
select N'art-auction',N'https://kymphillpotts.com/assets/images/posts/artauction-screen3.png' UNION ALL
select N'avatar login',N'https://i.imgur.com/8hQyajs.jpg' UNION ALL
select N'avatar login',N'https://i.imgur.com/faN2yIY.png' UNION ALL
select N'band-tracker',N'https://github.com/michaldivis/band-tracker-app/blob/master/screenshots/android_artist_detail.png?raw=true' UNION ALL
select N'band-tracker',N'https://github.com/michaldivis/band-tracker-app/blob/master/screenshots/android_artists.png?raw=true' UNION ALL
select N'band-tracker',N'https://github.com/michaldivis/band-tracker-app/blob/master/screenshots/android_dashboard.png?raw=true' UNION ALL
select N'band-tracker',N'https://github.com/michaldivis/band-tracker-app/blob/master/screenshots/android_release_detail.png?raw=true' UNION ALL
select N'band-tracker',N'https://github.com/michaldivis/band-tracker-app/blob/master/screenshots/android_upcoming_shows.png?raw=true' UNION ALL
select N'bet-app',N'https://raw.githubusercontent.com/RadekVyM/Bet-App/main/Images/betapp calendar.gif' UNION ALL
select N'bet-app',N'https://raw.githubusercontent.com/RadekVyM/Bet-App/main/Images/betapp.gif' UNION ALL
select N'maui-boomerang-card',N'https://github.com/shawyunz/BoomerangCard.Maui/blob/main/demo/demo.gif?raw=true' UNION ALL
select N'breadcrumb-control',N'https://raw.githubusercontent.com/IeuanWalker/Maui.Breadcrumb/master/Example.gif' UNION ALL
select N'breadcrumb-control',N'https://raw.githubusercontent.com/IeuanWalker/Maui.Breadcrumb/master/ProdExample.gif' UNION ALL
select N'calling-app',N'https://raw.githubusercontent.com/RadekVyM/Calling-App/main/Images/android_callingapp_call.gif' UNION ALL
select N'calling-app',N'https://raw.githubusercontent.com/RadekVyM/Calling-App/main/Images/ios_callingapp_call.png' UNION ALL
select N'calling-app',N'https://raw.githubusercontent.com/RadekVyM/Calling-App/main/Images/ios_callingapp_calling.png' UNION ALL
select N'calling-app',N'https://raw.githubusercontent.com/RadekVyM/Calling-App/main/Images/ios_callingapp_home.png' UNION ALL
select N'calling-app',N'https://raw.githubusercontent.com/RadekVyM/Calling-App/main/Images/windows_callingapp.gif' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/App.OnlyEssentialsFeatures/raw/master/App.Card' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/App.OnlyEssentialsFeatures/raw/master/App.CardTools/App.CardTools/Src/Screen/iOS/connection.png?raw=true' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/App.OnlyEssentialsFeatures/raw/master/App.CardTools/App.CardTools/Src/Screen/iOS/deviceinfo.png?raw=true' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/App.OnlyEssentialsFeatures/raw/master/App.CardTools/App.CardTools/Src/Screen/iOS/flashlight.png?raw=true' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/Xamarin.Essentials.FullAppFeatures/raw/master/App.CardTools/App.CardTools/Src/Screen/Android/connection.jpg?raw=true' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/Xamarin.Essentials.FullAppFeatures/raw/master/App.CardTools/App.CardTools/Src/Screen/Android/deviceinfo.jpg?raw=true' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/Xamarin.Essentials.FullAppFeatures/raw/master/App.CardTools/App.CardTools/Src/Screen/Android/flashlight.jpg?raw=true' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/Xamarin.Essentials.FullAppFeatures/raw/master/App.CardTools/App.CardTools/Src/Screen/Android/geolocation.jpg?raw=true' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/Xamarin.Essentials.FullAppFeatures/raw/master/App.CardTools/App.CardTools/Src/Screen/Android/magnometer.jpg?raw=true' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/Xamarin.Essentials.FullAppFeatures/raw/master/App.CardTools/App.CardTools/Src/Screen/Android/preference.jpg?raw=true' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/Xamarin.Essentials.FullAppFeatures/raw/master/App.CardTools/App.CardTools/Src/Screen/Android/texttospeak.jpg?raw=true' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/Xamarin.Essentials.FullAppFeatures/raw/master/App.CardTools/App.CardTools/Src/Screen/Android/unitconverter.jpg?raw=true' UNION ALL
select N'carousel-essentials',N'https://github.com/alexandresanlim/Xamarin.Essentials.FullAppFeatures/raw/master/App.CardTools/App.CardTools/Src/Screen/Android/whats.jpg?raw=true' UNION ALL
select N'carousel-essentials',N'https://raw.githubusercontent.com/alexandresanlim/App.OnlyEssentialsFeatures/master/App.CardTools/App.CardTools/Src/Screen/gif.gif' UNION ALL
select N'carousel-intro-page',N'https://raw.githubusercontent.com/LucioMSP/Xamarin.Forms.Examples/master/CarouselIntroPage/ScreenShots/CarouselIntroPage.gif' UNION ALL
select N'carousel-intro-page',N'https://raw.githubusercontent.com/LucioMSP/Xamarin.Forms.Examples/master/CarouselIntroPage/ScreenShots/ScreenShot01.png' UNION ALL
select N'carousel-intro-page',N'https://raw.githubusercontent.com/LucioMSP/Xamarin.Forms.Examples/master/CarouselIntroPage/ScreenShots/ScreenShot02.png' UNION ALL
select N'carousel-intro-page',N'https://raw.githubusercontent.com/LucioMSP/Xamarin.Forms.Examples/master/CarouselIntroPage/ScreenShots/ScreenShot03.png' UNION ALL
select N'chameleon',N'https://raw.githubusercontent.com/sthewissen/KickassUI.Chameleon/master/droid1.jpg' UNION ALL
select N'chameleon',N'https://raw.githubusercontent.com/sthewissen/KickassUI.Chameleon/master/droid2.jpg' UNION ALL
select N'chameleon',N'https://raw.githubusercontent.com/sthewissen/KickassUI.Chameleon/master/ios1.png' UNION ALL
select N'chameleon',N'https://raw.githubusercontent.com/sthewissen/KickassUI.Chameleon/master/ios2.png' UNION ALL
select N'Chased-Home-UI-Design',N'https://raw.githubusercontent.com/ufukhawk/Xamarin-Forms-UI-Library/master/Images/68747470733a2f2f696d6775722e636f6d2f4b614c417254562e706e67.png' UNION ALL
select N'Chased-Home-UI-Design',N'https://raw.githubusercontent.com/ufukhawk/Xamarin-Forms-UI-Library/master/Images/68747470733a2f2f696d6775722e636f6d2f646c32507145572e706e67.png' UNION ALL
select N'chick-and-paddy-dotnet-maui',N'https://raw.githubusercontent.com/tuyen-vuduc/chick-and-paddy-dotnet-maui/main/docs/images/news-feeds.png' UNION ALL
select N'chick-and-paddy-dotnet-maui',N'https://raw.githubusercontent.com/tuyen-vuduc/chick-and-paddy-dotnet-maui/main/docs/images/sign-in.png' UNION ALL
select N'chick-and-paddy-dotnet-maui',N'https://raw.githubusercontent.com/tuyen-vuduc/chick-and-paddy-dotnet-maui/main/docs/images/sign-up.png' UNION ALL
select N'chick-and-paddy-dotnet-maui',N'https://raw.githubusercontent.com/tuyen-vuduc/chick-and-paddy-dotnet-maui/main/docs/images/stories.png' UNION ALL
select N'concentric-onboarding',N'https://user-images.githubusercontent.com/19656249/68100432-cbe01f80-fea6-11e9-9044-fc3a10e4422a.gif' UNION ALL
select N'covid19-live',N'https://user-images.githubusercontent.com/11803107/79575316-f827db00-8097-11ea-826e-c94107b2ce1d.png' UNION ALL
select N'covid19-live',N'https://user-images.githubusercontent.com/11803107/79575346-04ac3380-8098-11ea-817e-5b663dd33a8a.png' UNION ALL
select N'covid19-live',N'https://user-images.githubusercontent.com/11803107/79575567-62d91680-8098-11ea-8655-6712af67776b.PNG' UNION ALL
select N'covid19-live',N'https://user-images.githubusercontent.com/11803107/79575597-6c627e80-8098-11ea-8e3a-fc6f218853e7.PNG' UNION ALL
select N'covid19-live',N'https://user-images.githubusercontent.com/11803107/79587522-0b8f7200-80a9-11ea-8830-3d293824acaa.gif' UNION ALL
select N'covid19-tracker-ui',N'https://raw.githubusercontent.com/AnthonyLatty/Covid19.Forms/master/Artwork/artwork_droid_1.jpg' UNION ALL
select N'covid19-tracker-ui',N'https://raw.githubusercontent.com/AnthonyLatty/Covid19.Forms/master/Artwork/artwork_droid_2.jpg' UNION ALL
select N'covid19-tracker-ui',N'https://raw.githubusercontent.com/AnthonyLatty/Covid19.Forms/master/Artwork/artwork_droid_3.jpg' UNION ALL
select N'covid19-tracker-ui',N'https://raw.githubusercontent.com/AnthonyLatty/Covid19.Forms/master/Artwork/artwork_ios_1.png' UNION ALL
select N'covid19-tracker-ui',N'https://raw.githubusercontent.com/AnthonyLatty/Covid19.Forms/master/Artwork/artwork_ios_2.png' UNION ALL
select N'covid19-tracker-ui',N'https://raw.githubusercontent.com/AnthonyLatty/Covid19.Forms/master/Artwork/artwork_ios_3.png' UNION ALL
select N'CovidTrack',N'https://raw.githubusercontent.com/Amaro96/CovidTrack/master/Screenshots/darkModeFirstScreen.png' UNION ALL
select N'CovidTrack',N'https://raw.githubusercontent.com/Amaro96/CovidTrack/master/Screenshots/light.PNG' UNION ALL
select N'CovidTrack',N'https://raw.githubusercontent.com/Amaro96/CovidTrack/master/Screenshots/ligthModeFirstScreen.PNG' UNION ALL
select N'CovidTrack',N'https://raw.githubusercontent.com/Amaro96/CovidTrack/master/Screenshots/mycountry.PNG' UNION ALL
select N'CovidTrack',N'https://raw.githubusercontent.com/Amaro96/CovidTrack/master/Screenshots/tela.PNG' UNION ALL
select N'credit-card-checkout',N'https://raw.githubusercontent.com/egbakou/CreditCardCheckout/master/design/Screenshot_20191105-112636.png' UNION ALL
select N'credit-card-checkout',N'https://raw.githubusercontent.com/egbakou/CreditCardCheckout/master/design/Screenshot_20191105-112705.png' UNION ALL
select N'credit-card-payment-ui',N'https://raw.githubusercontent.com/DamianSuess/Learn.MauiPaymentUi/master/SampleCards.gif' UNION ALL
select N'cruise-mobile-ui',N'https://github.com/andreas-nesheim/CruiseMobileUI/raw/master/Screenshots/screenshot1.png' UNION ALL
select N'cruise-mobile-ui',N'https://github.com/andreas-nesheim/CruiseMobileUI/raw/master/Screenshots/screenshot2.png' UNION ALL
select N'Dark-Store',N'https://raw.githubusercontent.com/ufukhawk/Xamarin-Forms-UI-Library/master/Images/Screen Shot 2020-07-25 at 09.38.22.png' UNION ALL
select N'dashboard-drawer',N'https://github.com/alexandresanlim/XamarinUI.Dashboard/raw/master/XamarinUI.Dashboard/XamarinUI.Dashboard/Src/Img/Screen/android.gif?raw=true' UNION ALL
select N'dashboard-drawer',N'https://github.com/alexandresanlim/XamarinUI.Dashboard/raw/master/XamarinUI.Dashboard/XamarinUI.Dashboard/Src/Img/Screen/ios.png?raw=true' UNION ALL
select N'day-vs-night',N'https://kymphillpotts.com/assets/images/posts/dayvsnight/day.png' UNION ALL
select N'day-vs-night',N'https://kymphillpotts.com/assets/images/posts/dayvsnight/night.png' UNION ALL
select N'discover-gists',N'https://github.com/alexandresanlim/DiscoverGists/blob/master/DiscoverGists/DiscoverGists/Src/Screenshots/iOS/0.png?raw=true' UNION ALL
select N'discover-gists',N'https://github.com/alexandresanlim/DiscoverGists/blob/master/DiscoverGists/DiscoverGists/Src/Screenshots/iOS/1.png?raw=true' UNION ALL
select N'discover-gists',N'https://github.com/alexandresanlim/DiscoverGists/blob/master/DiscoverGists/DiscoverGists/Src/Screenshots/iOS/2.png?raw=true' UNION ALL
select N'discover-gists',N'https://github.com/alexandresanlim/DiscoverGists/raw/master/DiscoverGists/DiscoverGists/Src/Screenshots/Android/0.png?raw=true' UNION ALL
select N'discover-gists',N'https://github.com/alexandresanlim/DiscoverGists/raw/master/DiscoverGists/DiscoverGists/Src/Screenshots/Android/1.png?raw=true' UNION ALL
select N'discover-gists',N'https://github.com/alexandresanlim/DiscoverGists/raw/master/DiscoverGists/DiscoverGists/Src/Screenshots/Android/2.png?raw=true' UNION ALL
select N'discover-gists',N'https://github.com/alexandresanlim/DiscoverGists/raw/master/DiscoverGists/DiscoverGists/Src/Screenshots/Android/3.png?raw=true' UNION ALL
select N'discover-gists',N'https://github.com/alexandresanlim/DiscoverGists/raw/master/DiscoverGists/DiscoverGists/Src/Screenshots/Android/4.png?raw=true' UNION ALL
select N'discover-gists',N'https://github.com/alexandresanlim/DiscoverGists/raw/master/DiscoverGists/DiscoverGists/Src/Screenshots/Android/5.png?raw=true' UNION ALL
select N'discover-gists',N'https://github.com/alexandresanlim/DiscoverGists/raw/master/DiscoverGists/DiscoverGists/Src/Screenshots/Android/6.png?raw=true' UNION ALL
select N'discover-gists',N'https://github.com/alexandresanlim/DiscoverGists/raw/master/DiscoverGists/DiscoverGists/Src/Screenshots/Android/7.png?raw=true' UNION ALL
select N'discover-gists',N'https://github.com/alexandresanlim/DiscoverGists/raw/master/DiscoverGists/DiscoverGists/Src/Screenshots/Android/animation.gif?raw=true' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/android_lessons_1.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/android_lessons_2.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/android_lessons_3.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/android_profile_1.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/android_profile_2.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/android_profile_3.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/android_profile_4.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/android_ranking_1.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/android_store_1.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/android_store_2.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/android_stories_1.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/android_stories_2.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/ios_lessons_1.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/ios_lessons_2.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/ios_lessons_3.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/ios_profile_1.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/ios_profile_2.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/ios_profile_3.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/ios_profile_4.png' UNION ALL
select N'duolingo-clone',N'https://raw.githubusercontent.com/ionixjunior/XFAppDuolingoClone/master/art/ios_stories_1.png' UNION ALL
select N'EcommerceUI',N'https://raw.githubusercontent.com/exendahal/EcommerceMAUI/master/Preview/1.png' UNION ALL
select N'EcommerceUI',N'https://raw.githubusercontent.com/exendahal/EcommerceMAUI/master/Preview/2.png' UNION ALL
select N'EcommerceUI',N'https://raw.githubusercontent.com/exendahal/EcommerceMAUI/master/Preview/3.png' UNION ALL
select N'EcommerceUI',N'https://raw.githubusercontent.com/exendahal/EcommerceMAUI/master/Preview/4.png' UNION ALL
select N'EcommerceUI',N'https://raw.githubusercontent.com/exendahal/EcommerceMAUI/master/Preview/5.png' UNION ALL
select N'EcommerceUI',N'https://raw.githubusercontent.com/exendahal/EcommerceMAUI/master/Preview/6.png' UNION ALL
select N'EcommerceUI',N'https://raw.githubusercontent.com/exendahal/EcommerceMAUI/master/Preview/7.png' UNION ALL
select N'EcommerceUI',N'https://raw.githubusercontent.com/exendahal/EcommerceMAUI/master/Preview/8.png' UNION ALL
select N'EcommerceUI',N'https://raw.githubusercontent.com/exendahal/EcommerceMAUI/master/Preview/9.png' UNION ALL
select N'Enlighten',N'https://user-images.githubusercontent.com/26998235/69323704-3f3aad00-0c6d-11ea-8195-6b5f1c64d665.jpg' UNION ALL
select N'Enlighten',N'https://user-images.githubusercontent.com/26998235/69323706-3f3aad00-0c6d-11ea-92f7-939a99ea58c9.jpg' UNION ALL
select N'Enlighten',N'https://user-images.githubusercontent.com/26998235/69323707-3f3aad00-0c6d-11ea-96f9-b04ccd6edd3d.jpg' UNION ALL
select N'Enlighten',N'https://user-images.githubusercontent.com/26998235/69323708-3fd34380-0c6d-11ea-9825-13964fe58206.jpg' UNION ALL
select N'Enlighten',N'https://user-images.githubusercontent.com/26998235/69323710-3fd34380-0c6d-11ea-9204-cc560d3050d3.jpg' UNION ALL
select N'Enlighten',N'https://user-images.githubusercontent.com/26998235/69323712-3fd34380-0c6d-11ea-8d48-2dd9cf5ff990.jpg' UNION ALL
select N'Enlighten',N'https://user-images.githubusercontent.com/26998235/69323714-406bda00-0c6d-11ea-9eac-f08220f21566.jpg' UNION ALL
select N'Enlighten',N'https://user-images.githubusercontent.com/26998235/69323716-406bda00-0c6d-11ea-993b-4d0ab21b46bf.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/android/Cart Page.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/android/Detail page.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/android/Location denied page.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/android/Login page.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/android/Onboarding.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/ios/Cart page.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/ios/Detail page.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/ios/Location denied page.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/ios/Login page.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/ios/Onboarding.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/uwp/Cart page.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/uwp/Detail.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/uwp/Location denied page.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/uwp/Login page.jpg' UNION ALL
select N'essential-ui-kit',N'https://cdn.syncfusion.com/essential-ui-kit-for-xamarin.forms/common/uikitimages/screenshots/uwp/Onboarding page.jpg' UNION ALL
select N'f1tv',N'https://user-images.githubusercontent.com/11583629/177056864-a8edd821-0cc5-469b-91f9-66e0051f6f35.png' UNION ALL
select N'facebook-mobile-app-login-ui-clone',N'https://raw.githubusercontent.com/SRKYousafzaiPK/FacebookMobileAppLoginUIClone/master/Screenshot.PNG' UNION ALL
select N'fancy-tutorial',N'https://raw.githubusercontent.com/sthewissen/KickassUI.FancyTutorial/master/android.jpg' UNION ALL
select N'fancy-tutorial',N'https://raw.githubusercontent.com/sthewissen/KickassUI.FancyTutorial/master/ios.png' UNION ALL
select N'fashion-store-ui',N'https://raw.githubusercontent.com/valentineg8/FashionStore/master/images/FashionStore.gif?raw=true' UNION ALL
select N'fashion-store-ui',N'https://raw.githubusercontent.com/valentineg8/FashionStore/master/images/FasionStoreAndroid.gif?raw=true' UNION ALL
select N'maui-finance',N'https://user-images.githubusercontent.com/20908430/183722589-87f62573-7e96-4bd4-bf3e-6cdd4e5ea0f5.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/Discover-Dark-Android.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/Discover-Dark-iOS.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/Discover-White-Android.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/Discover-White-iOS.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/Favourite-Dark-Android.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/Favourite-Dark-iOS.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/Favourite-White-Android.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/Favourite-White-iOS.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/MyOrders-Dark-Android.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/MyOrders-Dark-iOS.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/MyOrders-White-Android.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/MyOrders-White-iOS.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/MyProfile-Dark-Android.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/MyProfile-Dark-iOS.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/MyProfile-White-Android.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/MyProfile-White-iOS.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/SplashScreen-Android.png' UNION ALL
select N'foodapp',N'https://raw.githubusercontent.com/monetelli/XF_FoodApp/master/Images/SplashScreen-iOS.png' UNION ALL
select N'four-seasons',N'https://raw.githubusercontent.com/RadekVyM/FourSeasons/main/images/all_devices.png' UNION ALL
select N'four-seasons',N'https://raw.githubusercontent.com/RadekVyM/FourSeasons/main/images/android.gif' UNION ALL
select N'four-seasons',N'https://raw.githubusercontent.com/RadekVyM/FourSeasons/main/images/windows.gif' UNION ALL
select N'Chat app UI',N'https://raw.githubusercontent.com/DamienDoumer/freechat/master/images/freechatAndroidDemo.gif' UNION ALL
select N'Chat app UI',N'https://raw.githubusercontent.com/DamienDoumer/freechat/master/images/freechatiOSDemo.gif' UNION ALL
select N'gadgets-store-app',N'https://raw.githubusercontent.com/RadekVyM/Gadgets-Store-App/main/samples/gadget_store_detail.gif' UNION ALL
select N'gadgets-store-app',N'https://raw.githubusercontent.com/RadekVyM/Gadgets-Store-App/main/samples/gadget_store_home.gif' UNION ALL
select N'gadgets-store-app',N'https://raw.githubusercontent.com/RadekVyM/Gadgets-Store-App/main/samples/gadget_store_menu.gif' UNION ALL
select N'gadgets-store-app',N'https://raw.githubusercontent.com/RadekVyM/Gadgets-Store-App/main/samples/iphone_gadget_store_detail.png' UNION ALL
select N'gadgets-store-app',N'https://raw.githubusercontent.com/RadekVyM/Gadgets-Store-App/main/samples/iphone_gadget_store_home.png' UNION ALL
select N'gadgets-store-app',N'https://raw.githubusercontent.com/RadekVyM/Gadgets-Store-App/main/samples/iphone_gadget_store_menu.png' UNION ALL
select N'xf-games-chips',N'https://user-images.githubusercontent.com/11803107/80119193-c1523900-855f-11ea-864a-f44cb0c4a003.jpg' UNION ALL
select N'xf-games-chips',N'https://user-images.githubusercontent.com/11803107/80119227-cca56480-855f-11ea-8b44-e5c031d28428.PNG' UNION ALL
select N'xf-games-chips',N'https://user-images.githubusercontent.com/11803107/80120661-b698a380-8561-11ea-9faf-604dca45ff19.gif' UNION ALL
select N'great-places',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/82/132.jpg' UNION ALL
select N'great-places',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/82/133.jpg' UNION ALL
select N'homemadefood',N'https://raw.githubusercontent.com/ahdbk/MAUI.RecipiesApp/master/screenshots/01.gif' UNION ALL
select N'homemadefood',N'https://raw.githubusercontent.com/ahdbk/MAUI.RecipiesApp/master/screenshots/01.png' UNION ALL
select N'homemadefood',N'https://raw.githubusercontent.com/ahdbk/MAUI.RecipiesApp/master/screenshots/02.png' UNION ALL
select N'homemadefood',N'https://raw.githubusercontent.com/ahdbk/MAUI.RecipiesApp/master/screenshots/03.png' UNION ALL
select N'homemadefood',N'https://raw.githubusercontent.com/ahdbk/MAUI.RecipiesApp/master/screenshots/04.png' UNION ALL
select N'im-feeling-lucky',N'https://github.com/alexandresanlim/XamarinUI.ImFeelingLucky/raw/master/XamarinUI.ImFeelingLucky/XamarinUI.ImFeelingLucky/Src/Screen/android/1.jpg?raw=true' UNION ALL
select N'im-feeling-lucky',N'https://github.com/alexandresanlim/XamarinUI.ImFeelingLucky/raw/master/XamarinUI.ImFeelingLucky/XamarinUI.ImFeelingLucky/Src/Screen/android/2.jpg?raw=true' UNION ALL
select N'im-feeling-lucky',N'https://github.com/alexandresanlim/XamarinUI.ImFeelingLucky/raw/master/XamarinUI.ImFeelingLucky/XamarinUI.ImFeelingLucky/Src/Screen/android/3.jpg?raw=true' UNION ALL
select N'im-feeling-lucky',N'https://github.com/alexandresanlim/XamarinUI.ImFeelingLucky/raw/master/XamarinUI.ImFeelingLucky/XamarinUI.ImFeelingLucky/Src/Screen/gif.gif?raw=true' UNION ALL
select N'im-feeling-lucky',N'https://github.com/alexandresanlim/XamarinUI.ImFeelingLucky/raw/master/XamarinUI.ImFeelingLucky/XamarinUI.ImFeelingLucky/Src/Screen/ios/1.png?raw=true' UNION ALL
select N'im-feeling-lucky',N'https://github.com/alexandresanlim/XamarinUI.ImFeelingLucky/raw/master/XamarinUI.ImFeelingLucky/XamarinUI.ImFeelingLucky/Src/Screen/ios/2.png?raw=true' UNION ALL
select N'im-feeling-lucky',N'https://github.com/alexandresanlim/XamarinUI.ImFeelingLucky/raw/master/XamarinUI.ImFeelingLucky/XamarinUI.ImFeelingLucky/Src/Screen/ios/3.png?raw=true' UNION ALL
select N'in-space',N'https://raw.githubusercontent.com/sthewissen/KickassUI.InSpace/master/droid.jpg' UNION ALL
select N'in-space',N'https://raw.githubusercontent.com/sthewissen/KickassUI.InSpace/master/ios.png' UNION ALL
select N'initials-view',N'https://raw.githubusercontent.com/tsjdev-apps/xf-initialsview/master/Docs/InitialsView.gif' UNION ALL
select N'IspApp-ui',N'https://raw.githubusercontent.com/exendahal/Vianet/master/Screenshot/1.png' UNION ALL
select N'IspApp-ui',N'https://raw.githubusercontent.com/exendahal/Vianet/master/Screenshot/2.png' UNION ALL
select N'IspApp-ui',N'https://raw.githubusercontent.com/exendahal/Vianet/master/Screenshot/3.png' UNION ALL
select N'IspApp-ui',N'https://raw.githubusercontent.com/exendahal/Vianet/master/Screenshot/4.png' UNION ALL
select N'IspApp-ui',N'https://raw.githubusercontent.com/exendahal/Vianet/master/Screenshot/5.png' UNION ALL
select N'IspApp-ui',N'https://raw.githubusercontent.com/exendahal/Vianet/master/Screenshot/6.png' UNION ALL
select N'IspApp-ui',N'https://raw.githubusercontent.com/exendahal/Vianet/master/Screenshot/7.png' UNION ALL
select N'IspApp-ui',N'https://raw.githubusercontent.com/exendahal/Vianet/master/Screenshot/8.png' UNION ALL
select N'link-checker-charts',N'https://github.com/NogginBox/Link-Checker-Samples/raw/main/Screenshots/Screenshot-Chart-01.png' UNION ALL
select N'Listview-Item-Template',N'http://patrickgoode.com/wp-content/uploads/2019/11/screenshot-1573237095029.jpg' UNION ALL
select N'listview-timeline',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/79/130.jpg' UNION ALL
select N'listview-timeline',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/79/131.jpg' UNION ALL
select N'loan-calculator',N'https://raw.githubusercontent.com/syncfusion/xamarin-showcase-emi-calculator/master/images/Android/chart.png' UNION ALL
select N'loan-calculator',N'https://raw.githubusercontent.com/syncfusion/xamarin-showcase-emi-calculator/master/images/Android/excel.png' UNION ALL
select N'loan-calculator',N'https://raw.githubusercontent.com/syncfusion/xamarin-showcase-emi-calculator/master/images/Android/grid.png' UNION ALL
select N'loan-calculator',N'https://raw.githubusercontent.com/syncfusion/xamarin-showcase-emi-calculator/master/images/Android/home.png' UNION ALL
select N'loan-calculator',N'https://raw.githubusercontent.com/syncfusion/xamarin-showcase-emi-calculator/master/images/Android/share.png' UNION ALL
select N'loan-calculator',N'https://raw.githubusercontent.com/syncfusion/xamarin-showcase-emi-calculator/master/images/iOS/chart.png' UNION ALL
select N'loan-calculator',N'https://raw.githubusercontent.com/syncfusion/xamarin-showcase-emi-calculator/master/images/iOS/excel.png' UNION ALL
select N'loan-calculator',N'https://raw.githubusercontent.com/syncfusion/xamarin-showcase-emi-calculator/master/images/iOS/grid.png' UNION ALL
select N'loan-calculator',N'https://raw.githubusercontent.com/syncfusion/xamarin-showcase-emi-calculator/master/images/iOS/home.png' UNION ALL
select N'loan-calculator',N'https://raw.githubusercontent.com/syncfusion/xamarin-showcase-emi-calculator/master/images/iOS/share.png' UNION ALL
select N'login-with-imageentry',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/68/114.jpg' UNION ALL
select N'maui-delivery',N'https://user-images.githubusercontent.com/9836726/187585035-1c943f33-d881-4572-977c-d560ae84c755.jpg' UNION ALL
select N'market-growth-strategy',N'https://raw.githubusercontent.com/Riccardo11/MarketGrowthStrategy/master/images/Screenshot1.png' UNION ALL
select N'market-growth-strategy',N'https://raw.githubusercontent.com/Riccardo11/MarketGrowthStrategy/master/images/Screenshot2.png' UNION ALL
select N'market-growth-strategy',N'https://raw.githubusercontent.com/Riccardo11/MarketGrowthStrategy/master/images/Screenshot3.png' UNION ALL
select N'marvel-cards',N'https://raw.githubusercontent.com/kphillpotts/MarvelCards/master/design/Screenshot_1565521630.png' UNION ALL
select N'maui-matching-game',N'https://github.com/shawyunz/Matching.Maui/blob/master/demo/demo.gif?raw=true' UNION ALL
select N'maui-2048-game-clone',N'https://raw.githubusercontent.com/codeanees/2048Maui/4863492e7d9660c3fd9bdffe90aa26eb6d00e20f/Images/maui2048_play.gif' UNION ALL
select N'maui-2048-game-clone',N'https://raw.githubusercontent.com/codeanees/2048Maui/main/Images/001.jpg' UNION ALL
select N'maui-2048-game-clone',N'https://raw.githubusercontent.com/codeanees/2048Maui/main/Images/002.jpg' UNION ALL
select N'maui-bmi-calc',N'https://user-images.githubusercontent.com/103980/185797398-bc4883c9-3b4f-4754-acfd-d2a985d61463.png' UNION ALL
select N'maui-bmi-calc',N'https://user-images.githubusercontent.com/103980/185797403-66ef1e5f-ce64-4500-a810-faade573d63c.png' UNION ALL
select N'maui-bmi-calc',N'https://user-images.githubusercontent.com/103980/185797405-8bdc2f4b-2d9c-4910-9cbb-eb67f0d9801d.png' UNION ALL
select N'dotnet-maui-bank',N'https://ik.imagekit.io/VladislavAntonyuk/vladislavantonyuk/articles/23/dotnet-maui-bank-app.gif' UNION ALL
select N'Logbook for Vehicle',N'https://user-images.githubusercontent.com/40561661/187639753-5e180a03-a176-469c-9f27-5910c0635e12.png' UNION ALL
select N'Logbook for Vehicle',N'https://user-images.githubusercontent.com/40561661/187639805-ddecec21-5ba3-4598-88fd-6e58b22b9b4d.png' UNION ALL
select N'maui-ms-dos',N'https://github.com/jm-parent/MSDos4Ever/blob/master/MSDos4Ever/SnpptsImages/msdos_ios_landscape.png?raw=true' UNION ALL
select N'maui-ms-dos',N'https://github.com/jm-parent/MSDos4Ever/blob/master/MSDos4Ever/SnpptsImages/msdos_ios_portrait.png?raw=true' UNION ALL
select N'maui-ms-dos',N'https://github.com/jm-parent/MSDos4Ever/blob/master/MSDos4Ever/SnpptsImages/msdos_windows.png?raw=true' UNION ALL
select N'MauiBlazorWeb',N'https://raw.githubusercontent.com/kevmoens/MauiBlazorWeb/main/example1.png' UNION ALL
select N'maui-planets',N'https://github.com/naweed/MauiPlanets/blob/main/Images/001.png?raw=true' UNION ALL
select N'maui-planets',N'https://github.com/naweed/MauiPlanets/blob/main/Images/002.png?raw=true' UNION ALL
select N'maui-planets',N'https://github.com/naweed/MauiPlanets/blob/main/Images/003.png?raw=true' UNION ALL
select N'maui-rating-view',N'https://github.com/naweed/Maui.Controls.RatingView/blob/main/RattingScreenShot.png?raw=true' UNION ALL
select N'maui-sci-calc',N'https://github.com/naweed/MauiScientificCalculator/blob/main/CalcScreen.png?raw=true' UNION ALL
select N'maui-tube-player',N'https://github.com/naweed/MauiTubePlayer/blob/main/TubePlayerScreenShot.png?raw=true' UNION ALL
select N'MbongoUI',N'https://raw.githubusercontent.com/Amaro96/MbongoUIApp/master/ScreenShots/bankTransfer.PNG' UNION ALL
select N'MbongoUI',N'https://raw.githubusercontent.com/Amaro96/MbongoUIApp/master/ScreenShots/Mobile money.PNG' UNION ALL
select N'movie-app',N'https://raw.githubusercontent.com/RadekVyM/Movie-App/main/Images/detailpageIronman.jpg' UNION ALL
select N'movie-app',N'https://raw.githubusercontent.com/RadekVyM/Movie-App/main/Images/detailpageThor.gif' UNION ALL
select N'movie-app',N'https://raw.githubusercontent.com/RadekVyM/Movie-App/main/Images/drstrange.jpg' UNION ALL
select N'movie-app',N'https://raw.githubusercontent.com/RadekVyM/Movie-App/main/Images/ironman.jpg' UNION ALL
select N'movie-app',N'https://raw.githubusercontent.com/RadekVyM/Movie-App/main/Images/mainpage.gif' UNION ALL
select N'music-streaming-stats',N'https://github.com/michaldivis/music-streaming-stats-ui/blob/master/screenshots/android.png?raw=true' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Gifs/change_langage.gif' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Gifs/change_theme.gif' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Gifs/full.gif' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Screenshots/Dark/configuration.jpeg' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Screenshots/Dark/home.jpeg' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Screenshots/Dark/profile_grid.jpeg' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Screenshots/Dark/trends.jpeg' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Screenshots/Dark/wallet.jpeg' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Screenshots/Light/configuration.jpeg' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Screenshots/Light/home.jpeg' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Screenshots/Light/profile_grid.jpeg' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Screenshots/Light/trends.jpeg' UNION ALL
select N'NFTWallet',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-nft-wallet/main/Images/Android/Screenshots/Light/wallet.jpeg' UNION ALL
select N'netflix-clone',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/85/136.jpg' UNION ALL
select N'netflix-clone',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/85/137.jpg' UNION ALL
select N'netflix-clone',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/85/138.jpg' UNION ALL
select N'nubank-clone',N'https://user-images.githubusercontent.com/19656249/59728878-68bd5b80-922b-11e9-949a-a28b086868ec.png' UNION ALL
select N'nubank-clone',N'https://user-images.githubusercontent.com/19656249/59871956-213fe800-936f-11e9-819e-de366123feb1.gif' UNION ALL
select N'nubank-clone',N'https://user-images.githubusercontent.com/19656249/67351780-b2dd8300-f524-11e9-9b9d-39909880d6fe.gif' UNION ALL
select N'nubank-similar-timeline',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/138/166.jpg' UNION ALL
select N'nubank-similar-timeline',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/138/167.jpg' UNION ALL
select N'parallax-carousel',N'https://raw.githubusercontent.com/sthewissen/KickassUI.ParallaxCarousel/master/droid1.jpg' UNION ALL
select N'parallax-carousel',N'https://raw.githubusercontent.com/sthewissen/KickassUI.ParallaxCarousel/master/droid2.jpg' UNION ALL
select N'parallax-carousel',N'https://raw.githubusercontent.com/sthewissen/KickassUI.ParallaxCarousel/master/ios1.png' UNION ALL
select N'parallax-carousel',N'https://raw.githubusercontent.com/sthewissen/KickassUI.ParallaxCarousel/master/ios2.png' UNION ALL
select N'Parallax-Effect',N'https://github.com/ValonK/Xamarin.Forms.Parallax/raw/main/assets/showcase.gif?raw=true' UNION ALL
select N'personal-finances-dashboard',N'https://raw.githubusercontent.com/ricardoprestes/MyDimDim/master/screenshot/Android.jpg' UNION ALL
select N'personal-finances-dashboard',N'https://raw.githubusercontent.com/ricardoprestes/MyDimDim/master/screenshot/iOS.png' UNION ALL
select N'picture-download-failed-animation',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/140/168.jpg' UNION ALL
select N'picture-download-failed-animation',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/140/169.jpg' UNION ALL
select N'picture-download-failed-animation',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/140/170.jpg' UNION ALL
select N'pin-based-login',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/18/60.jpg' UNION ALL
select N'pin-based-login',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/18/61.jpg' UNION ALL
select N'places-app-ui',N'https://raw.githubusercontent.com/valentineg8/PlacesApp/master/images/android.gif?raw=true' UNION ALL
select N'places-app-ui',N'https://raw.githubusercontent.com/valentineg8/PlacesApp/master/images/ios.gif?raw=true' UNION ALL
select N'plantish',N'https://raw.githubusercontent.com/haavamoa/Plantish/master/assets/AddPlant.png' UNION ALL
select N'plantish',N'https://raw.githubusercontent.com/haavamoa/Plantish/master/assets/AddPlant_WithPicture.png' UNION ALL
select N'plantish',N'https://raw.githubusercontent.com/haavamoa/Plantish/master/assets/Plants.png' UNION ALL
select N'plantish',N'https://raw.githubusercontent.com/haavamoa/Plantish/master/assets/SplashScreen.png' UNION ALL
select N'poke-app',N'https://raw.githubusercontent.com/kainaalmeida/pokeapp/master/Screenshots/galeria.png' UNION ALL
select N'poke-app',N'https://raw.githubusercontent.com/kainaalmeida/pokeapp/master/Screenshots/galeriaAndroid.jpg' UNION ALL
select N'poke-app',N'https://raw.githubusercontent.com/kainaalmeida/pokeapp/master/Screenshots/pokemons.png' UNION ALL
select N'poke-app',N'https://raw.githubusercontent.com/kainaalmeida/pokeapp/master/Screenshots/pokemonsAndroid.jpg' UNION ALL
select N'poke-app',N'https://raw.githubusercontent.com/kainaalmeida/pokeapp/master/Screenshots/popup.png' UNION ALL
select N'poke-app',N'https://raw.githubusercontent.com/kainaalmeida/pokeapp/master/Screenshots/popupAndroid.jpg' UNION ALL
select N'poke-app',N'https://raw.githubusercontent.com/kainaalmeida/pokeapp/master/Screenshots/splash.png' UNION ALL
select N'poke-app',N'https://raw.githubusercontent.com/kainaalmeida/pokeapp/master/Screenshots/splashAndroid.jpg' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Gifs/Details.gif' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Gifs/Generations.gif' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Gifs/HomePage.gif' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Gifs/Search.gif' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Gifs/Sort.gif' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Gifs/SortGeneration.gif' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Screenshots/Details_About.jpeg' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Screenshots/Details_Evolution.jpeg' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Screenshots/Details_Stats.jpeg' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Screenshots/Filters.jpeg' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Screenshots/Generations.jpeg' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Screenshots/HomePage.jpeg' UNION ALL
select N'pokedexXF',N'https://raw.githubusercontent.com/ErickSilva2605/xamarinforms-pokedex/main/Images/Android/Screenshots/Sort.jpeg' UNION ALL
select N'pretty-face-app',N'https://raw.githubusercontent.com/InnovoTecnologias/PrettyFaceApp/master/Media/PrettyFaceApp.gif' UNION ALL
select N'pretty-face-app',N'https://raw.githubusercontent.com/InnovoTecnologias/PrettyFaceApp/master/Media/Preview1.jpg' UNION ALL
select N'pretty-face-app',N'https://raw.githubusercontent.com/InnovoTecnologias/PrettyFaceApp/master/Media/Preview2.jpg' UNION ALL
select N'pretty-face-app',N'https://raw.githubusercontent.com/InnovoTecnologias/PrettyFaceApp/master/Media/Preview3.jpg' UNION ALL
select N'pretty-face-app',N'https://raw.githubusercontent.com/InnovoTecnologias/PrettyFaceApp/master/Media/Preview4.jpg' UNION ALL
select N'pretty-face-app',N'https://raw.githubusercontent.com/InnovoTecnologias/PrettyFaceApp/master/Media/Preview5.jpg' UNION ALL
select N'realestateapp',N'https://raw.githubusercontent.com/marcfabregatb/RealEstate.App/main/realEstateApp.gif' UNION ALL
select N'register-with-imageentry',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/69/116.jpg' UNION ALL
select N'RunAway!',N'https://raw.githubusercontent.com/roubachof/SkiaSharpnado/master/__Docs__/activity_header_page_ios.png' UNION ALL
select N'RunAway!',N'https://raw.githubusercontent.com/roubachof/SkiaSharpnado/master/__Docs__/activity_page_android_4dp.png' UNION ALL
select N'RunAway!',N'https://raw.githubusercontent.com/roubachof/SkiaSharpnado/master/__Docs__/activity_page_ios_4dp.png' UNION ALL
select N'RunAway!',N'https://raw.githubusercontent.com/roubachof/SkiaSharpnado/master/__Docs__/glenn_thick.png' UNION ALL
select N'runkeeper-clone',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/49/126.jpg' UNION ALL
select N'runkeeper-clone',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/49/127.jpg' UNION ALL
select N'runkeeper-clone',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/49/128.jpg' UNION ALL
select N'runkeeper-clone',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/49/129.jpg' UNION ALL
select N'salon-mobile',N'https://raw.githubusercontent.com/kainaalmeida/SalonMobile/master/screenshots/droid01.jpg' UNION ALL
select N'salon-mobile',N'https://raw.githubusercontent.com/kainaalmeida/SalonMobile/master/screenshots/droid02.jpg' UNION ALL
select N'salon-mobile',N'https://raw.githubusercontent.com/kainaalmeida/SalonMobile/master/screenshots/iOS01.png' UNION ALL
select N'salon-mobile',N'https://raw.githubusercontent.com/kainaalmeida/SalonMobile/master/screenshots/iOS02.png' UNION ALL
select N'simple-listview-with-cards',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/123/151.jpg' UNION ALL
select N'simple-login',N'https://raw.githubusercontent.com/leijae/SimpleLogin/master/SimpleLogin/SimpleLogin/SimpleLogin/Screenshot/login.png' UNION ALL
select N'simple-rating-control-maui',N'https://raw.githubusercontent.com/tsjdev-apps/simpleratingcontrol.maui/main/docs/sample-android.png' UNION ALL
select N'simple-rating-control-maui',N'https://raw.githubusercontent.com/tsjdev-apps/simpleratingcontrol.maui/main/docs/sample-windows.png' UNION ALL
select N'skia-gauge-chart',N'https://miro.medium.com/max/1011/1*noyssgwjdBPHXnqu7IAtqw.gif' UNION ALL
select N'skia-gauge-chart',N'https://miro.medium.com/max/238/1*df_vGdlRXUmIP3UumAi_hg.png' UNION ALL
select N'skia-gauge-chart',N'https://user-images.githubusercontent.com/19656249/68064111-40c02780-fcf6-11e9-85c8-0fdd45caf3eb.gif' UNION ALL
select N'smart-home-app',N'https://user-images.githubusercontent.com/19656249/80289178-62cdbc00-8713-11ea-9333-5e13ad8bc7fc.gif' UNION ALL
select N'smoothies',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/28/71.jpg' UNION ALL
select N'smoothies',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/28/72.jpg' UNION ALL
select N'social-network',N'https://raw.githubusercontent.com/kphillpotts/XamarinFormsLayoutChallenges/master/SocialNetwork/Screenshots/iPhone6-33.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ioni' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_home_1_dark.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_home_1_light.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_library_1_dark.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_library_1_light.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_library_2_dark.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_library_2_light.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_search_1_dark.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_search_1_light.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_search_2_dark.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_search_2_light.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_search_3_dark.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_search_3_light.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_stream_1_dark.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/android_stream_1_light.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/ios_home_1_dark.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/ios_home_1_light.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/ios_search_1_dark.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/ios_search_1_light.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/ios_stream_1_dark.png' UNION ALL
select N'soundcloud-clone',N'https://raw.githubusercontent.com/ionixjunior/SoundCloudClone/master/art/ios_stream_1_light.png' UNION ALL
select N'spotify-clone',N'https://raw.githubusercontent.com/sthewissen/KickassUI.Spotify/master/images/spotify1.jpg' UNION ALL
select N'spotify-clone',N'https://raw.githubusercontent.com/sthewissen/KickassUI.Spotify/master/images/spotify2.jpg' UNION ALL
select N'spotify-clone',N'https://raw.githubusercontent.com/sthewissen/KickassUI.Spotify/master/images/spotify3.jpg' UNION ALL
select N'spotify-clone',N'https://raw.githubusercontent.com/sthewissen/KickassUI.Spotify/master/images/spotify4.jpg' UNION ALL
select N'subscription-plan',N'https://github.com/alexandresanlim/XamarinUI.SubscriptionPlan/raw/master/SubscriptionPlan.XamarinUI/SubscriptionPlan.XamarinUI/Screenshots/animation.gif?raw=true' UNION ALL
select N'subscription-plan',N'https://raw.githubusercontent.com/alexandresanlim/SubscriptionPlan.XamarinUI/master/SubscriptionPlan.XamarinUI/SubscriptionPlan.XamarinUI/Screenshots/android.jpg' UNION ALL
select N'subscription-plan',N'https://raw.githubusercontent.com/alexandresanlim/SubscriptionPlan.XamarinUI/master/SubscriptionPlan.XamarinUI/SubscriptionPlan.XamarinUI/Screenshots/ios.png' UNION ALL
select N'tattoo',N'https://user-images.githubusercontent.com/5494166/187275635-adbd12b6-dc4c-464f-a265-203ab1fe6e64.png' UNION ALL
select N'tattoo',N'https://user-images.githubusercontent.com/5494166/187275659-7b4599d2-6d17-47a9-94d4-da59ef722eb4.png' UNION ALL
select N'temperature-calculator',N'https://raw.githubusercontent.com/sergy2k/CentiFahrCalc/master/.github/images/TemperatureCalculatorScreenshot01.jpg' UNION ALL
select N'tiktok',N'https://github.com/ValonK/Xamarin.Forms.TikTok/raw/main/assets/1.png?raw=true' UNION ALL
select N'tiktok',N'https://github.com/ValonK/Xamarin.Forms.TikTok/raw/main/assets/2.png?raw=true' UNION ALL
select N'timeline-with-images',N'https://raw.githubusercontent.com/egbakou/Timeline/master/Timeline/screenshots/Screenshot_1.png' UNION ALL
select N'timeline-with-images',N'https://raw.githubusercontent.com/egbakou/Timeline/master/Timeline/screenshots/Screenshot_2.png' UNION ALL
select N'timeline-with-images',N'https://raw.githubusercontent.com/egbakou/Timeline/master/Timeline/screenshots/Screenshot_3.png' UNION ALL
select N'todo-app-xamarin-forms',N'https://raw.githubusercontent.com/tuyen-vuduc/todo-app-xamarin-forms/master/docs/images/home-delete.png' UNION ALL
select N'todo-app-xamarin-forms',N'https://raw.githubusercontent.com/tuyen-vuduc/todo-app-xamarin-forms/master/docs/images/home-empty.png' UNION ALL
select N'todo-app-xamarin-forms',N'https://raw.githubusercontent.com/tuyen-vuduc/todo-app-xamarin-forms/master/docs/images/home-sidebar.png' UNION ALL
select N'todo-app-xamarin-forms',N'https://raw.githubusercontent.com/tuyen-vuduc/todo-app-xamarin-forms/master/docs/images/home-with-todos.png' UNION ALL
select N'todo-app-xamarin-forms',N'https://raw.githubusercontent.com/tuyen-vuduc/todo-app-xamarin-forms/master/docs/images/new-todo.png' UNION ALL
select N'todo-app-xamarin-forms',N'https://raw.githubusercontent.com/tuyen-vuduc/todo-app-xamarin-forms/master/docs/images/new-todo-filled.png' UNION ALL
select N'TodoMe',N'https://raw.githubusercontent.com/behl1anmol/Todo.me/master/Screenshots/Maui_app_todo.gif' UNION ALL
select N'TodoMe',N'https://raw.githubusercontent.com/behl1anmol/Todo.me/master/Screenshots/TodoDetailsView.jpg' UNION ALL
select N'TodoMe',N'https://raw.githubusercontent.com/behl1anmol/Todo.me/master/Screenshots/TodoView.jpg' UNION ALL
select N'traveler',N'https://raw.githubusercontent.com/sthewissen/KickassUI.Traveler/master/droid.jpg' UNION ALL
select N'traveler',N'https://raw.githubusercontent.com/sthewissen/KickassUI.Traveler/master/ios.png' UNION ALL
select N'trips',N'https://raw.githubusercontent.com/shanranm/Trips/master/screens/recording.gif' UNION ALL
select N'twitter-clone',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/29/121.jpg' UNION ALL
select N'twitter-clone',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/29/122.jpg' UNION ALL
select N'twitter-clone',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/29/124.jpg' UNION ALL
select N'twitter-clone',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/29/125.jpg' UNION ALL
select N'ui-app-login',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/63/110.jpg' UNION ALL
select N'uber-clone',N'https://raw.githubusercontent.com/CrossGeeks/xUber/master/Screenshots/screenshot1.png' UNION ALL
select N'uber-clone',N'https://raw.githubusercontent.com/CrossGeeks/xUber/master/Screenshots/screenshot2.png' UNION ALL
select N'uber-clone',N'https://raw.githubusercontent.com/CrossGeeks/xUber/master/Screenshots/screenshot3.png' UNION ALL
select N'uber-clone',N'https://raw.githubusercontent.com/CrossGeeks/xUber/master/Screenshots/screenshot4.png' UNION ALL
select N'uber-clone',N'https://raw.githubusercontent.com/CrossGeeks/xUber/master/Screenshots/screenshot5.png' UNION ALL
select N'voucher',N'https://github.com/alexandresanlim/XamarinUI.Voucher/raw/master/XamarinUI.Voucher/XamarinUI.Voucher/src/screen/android/1.jpg?raw=true' UNION ALL
select N'voucher',N'https://github.com/alexandresanlim/XamarinUI.Voucher/raw/master/XamarinUI.Voucher/XamarinUI.Voucher/src/screen/demo.gif?raw=true' UNION ALL
select N'voucher',N'https://github.com/alexandresanlim/XamarinUI.Voucher/raw/master/XamarinUI.Voucher/XamarinUI.Voucher/src/screen/ios/1.png?raw=true' UNION ALL
select N'voucher',N'https://github.com/alexandresanlim/XamarinUI.Voucher/raw/master/XamarinUI.Voucher/XamarinUI.Voucher/src/screen/ios/2.png?raw=true' UNION ALL
select N'xamarinforms-wallet-creditcard',N'https://user-images.githubusercontent.com/11803107/80869536-8ba40300-8c77-11ea-975f-1f90b0973430.jpg' UNION ALL
select N'xamarinforms-wallet-creditcard',N'https://user-images.githubusercontent.com/11803107/80869544-9494d480-8c77-11ea-93f6-4a1f4449ee8c.jpg' UNION ALL
select N'xamarinforms-wallet-creditcard',N'https://user-images.githubusercontent.com/11803107/80869565-9eb6d300-8c77-11ea-9ff8-6894ba0dd743.JPG' UNION ALL
select N'xamarinforms-wallet-creditcard',N'https://user-images.githubusercontent.com/11803107/80869572-a8403b00-8c77-11ea-88ab-cdc322b4f738.JPG' UNION ALL
select N'xamarinforms-wallet-creditcard',N'https://user-images.githubusercontent.com/11803107/80870446-daa06700-8c7c-11ea-8d7a-2487b95b01a7.gif' UNION ALL
select N'waste-app',N'https://raw.githubusercontent.com/RadekVyM/Waste-App/main/Images/detailpage.jpg' UNION ALL
select N'waste-app',N'https://raw.githubusercontent.com/RadekVyM/Waste-App/main/Images/homepage.gif' UNION ALL
select N'waste-app',N'https://raw.githubusercontent.com/RadekVyM/Waste-App/main/Images/scan.jpg' UNION ALL
select N'weather-app-ui',N'https://raw.githubusercontent.com/valentineg8/WeatherApp/master/images/android.gif?raw=true' UNION ALL
select N'weather-app-ui',N'https://raw.githubusercontent.com/valentineg8/WeatherApp/master/images/ios.gif?raw=true' UNION ALL
select N'weather-xam',N'https://github.com/AizenDong/WeatherXam/blob/master/Images/Weather.gif?raw=true' UNION ALL
select N'weather-xam',N'https://raw.githubusercontent.com/AizenDong/WeatherXam/master/Images/HomePageDark1.jpg' UNION ALL
select N'weather-xam',N'https://raw.githubusercontent.com/AizenDong/WeatherXam/master/Images/HomePageDark2.jpg' UNION ALL
select N'weather-xam',N'https://raw.githubusercontent.com/AizenDong/WeatherXam/master/Images/HomePageLight1.jpg' UNION ALL
select N'weather-xam',N'https://raw.githubusercontent.com/AizenDong/WeatherXam/master/Images/HomePageLight2.jpg' UNION ALL
select N'weather-xam',N'https://raw.githubusercontent.com/AizenDong/WeatherXam/master/Images/ManageCityPageDark.jpg' UNION ALL
select N'weather-xam',N'https://raw.githubusercontent.com/AizenDong/WeatherXam/master/Images/ManageCityPageLight.jpg' UNION ALL
select N'weather-xam',N'https://raw.githubusercontent.com/AizenDong/WeatherXam/master/Images/SearchPageDark.jpg' UNION ALL
select N'weather-xam',N'https://raw.githubusercontent.com/AizenDong/WeatherXam/master/Images/SearchPageLight.jpg' UNION ALL
select N'weather-xam',N'https://raw.githubusercontent.com/AizenDong/WeatherXam/master/Images/SettingsDark.jpg' UNION ALL
select N'weather-xam',N'https://raw.githubusercontent.com/AizenDong/WeatherXam/master/Images/SettingsLight.jpg' UNION ALL
select N'welcome-page',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/147/176.jpg' UNION ALL
select N'welcome-page',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/147/177.jpg' UNION ALL
select N'welcome-pages',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/103/143.jpg' UNION ALL
select N'welcome-pages',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/103/144.jpg' UNION ALL
select N'welcome-pages',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/103/145.jpg' UNION ALL
select N'welcome-pages',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/103/146.jpg' UNION ALL
select N'welcome-pages',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/103/147.jpg' UNION ALL
select N'welcome-pages',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/103/148.jpg' UNION ALL
select N'welcome-pages',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/103/149.jpg' UNION ALL
select N'welcome-pages',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/103/150.jpg' UNION ALL
select N'whatsapp-chat-list',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/137/164.jpg' UNION ALL
select N'whatsapp-chat-list',N'https://raw.githubusercontent.com/snpptsdev/MigratedImages/master/137/165.jpg' UNION ALL
select N'whatsapp-ui',N'https://raw.githubusercontent.com/egbakou/WhatsAppUI/master/WhatsAppUI/screenshots/Screenshot_20190504-153320.png' UNION ALL
select N'whatsapp-ui',N'https://raw.githubusercontent.com/egbakou/WhatsAppUI/master/WhatsAppUI/screenshots/Screenshot_20190504-153321.png' UNION ALL
select N'whatsapp-ui',N'https://raw.githubusercontent.com/egbakou/WhatsAppUI/master/WhatsAppUI/screenshots/Screenshot_20190504-153403.png' UNION ALL
select N'whatsapp-ui',N'https://raw.githubusercontent.com/egbakou/WhatsAppUI/master/WhatsAppUI/screenshots/Screenshot_20190504-153435.png' UNION ALL
select N'whatsapp-ui',N'https://raw.githubusercontent.com/egbakou/WhatsAppUI/master/WhatsAppUI/screenshots/Screenshot_20190504-153734.png' UNION ALL
select N'whatsapp-ui',N'https://raw.githubusercontent.com/egbakou/WhatsAppUI/master/WhatsAppUI/screenshots/Screenshot_20190504-153830.png' UNION ALL
select N'xamarinforms-ecommerce-headphones',N'https://user-images.githubusercontent.com/11803107/83947598-5cd8f980-a7ee-11ea-86a6-ea9567a6906b.jpg' UNION ALL
select N'xamarinforms-ecommerce-headphones',N'https://user-images.githubusercontent.com/11803107/83947601-64000780-a7ee-11ea-82cc-dfbe14322e21.jpg' UNION ALL
select N'xamarinforms-ecommerce-headphones',N'https://user-images.githubusercontent.com/11803107/83947639-9f9ad180-a7ee-11ea-840c-919acbfe681b.PNG' UNION ALL
select N'xamarinforms-ecommerce-headphones',N'https://user-images.githubusercontent.com/11803107/83947643-a6c1df80-a7ee-11ea-9922-824b9aab951e.PNG' UNION ALL
select N'xamarinforms-ecommerce-headphones',N'https://user-images.githubusercontent.com/11803107/83947779-89d9dc00-a7ef-11ea-8ac8-e212a32c106d.gif' UNION ALL
select N'XamarinForms-PhotoStock-UI-Design',N'https://raw.githubusercontent.com/ufukhawk/Xamarin-Forms-UI-Library/master/Images/PhotoStock.gif' UNION ALL
select N'XamarinForms-PhotoStock-UI-Design',N'https://raw.githubusercontent.com/ufukhawk/Xamarin-Forms-UI-Library/master/Images/PhotoStock.png' UNION ALL
select N'XamarinForms-PhotoStock-UI-Design',N'https://raw.githubusercontent.com/ufukhawk/Xamarin-Forms-UI-Library/master/Images/PhotoStocksc2.png' UNION ALL
select N'xam-book-library',N'https://raw.githubusercontent.com/shanranm/XamBookLibrary/master/screens/recorded.gif' UNION ALL
select N'Xam-Call',N'https://raw.githubusercontent.com/ufukhawk/Xamarin-Forms-UI-Library/master/Images/xamcall.gif' UNION ALL
select N'Xam-Login-UI-Demo',N'https://raw.githubusercontent.com/ufukhawk/Xamarin-Forms-UI-Library/master/Images/sc_10.png' UNION ALL
select N'Xam-Login-UI-Demo',N'https://raw.githubusercontent.com/ufukhawk/Xamarin-Forms-UI-Library/master/Images/sc_13.png' UNION ALL
select N'Xam-Login-UI-Demo',N'https://raw.githubusercontent.com/ufukhawk/Xamarin-Forms-UI-Library/master/Images/sc_14.png';
GO
