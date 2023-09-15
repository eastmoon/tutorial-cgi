# CGI ( Common Gateway Interface )

通用閘道器介面 ( Common Gateway Interface ) 是為提供網路服務內容而執行控制台應用 (或稱命令列介面）的程式，以達到伺服器上實現動態網頁的通用協定；通常情況下，一次請求對應一個 CGI 指令的執行，並對等生成一個 HTML 作為回應。

![Common Gateway Interface work flow](https://mixwithmarketing.com/wp-content/uploads/2022/02/Common-Gateway-Interface.png)

在 [Server side scripting](https://en.wikipedia.org/wiki/Server-side_scripting) 的歷史演進說明裡，在 CGI 推出的 1993 年後，1994 年網景 ( Netscape ) 推出了一套基於 JavaScript 的伺服器端腳本，而其設計目的是要以腳本方式替代 CGI 中採用 C / C++ / Perl 這類由作業系統執行的語言，並讓腳本受到伺服器服務的管理；可以理解為是避免開發人員，因使用作業系統層級的指令導致如錯誤記憶體配置等，嚴重可使系統崩潰的錯誤。

在此之後，伺服器端腳本逐一發展，即後續常見的 ASP、PHP、JSP 等多樣的伺服器端腳本；其後，前後端分離，從伺服器端腳本中抽離 HTML 產生交由前端框架，以 RestFul 為標準的建立 WebAPI 框架；直到最年的 Server side rendering ( SSR )，將 JavaScript 的 Rendering 框架交由後端處理，減輕瀏覽器在第一次繪製的處理耗損。

跟隨歷史的演進來看，CGI 本身即是最原始且靈活伺服器端腳本，亦可根據其設計需要選擇效率更高的作業系統語言，以此達成 Server side scripting 或 Server side rendering；但需注意，這樣的設計應考量在受限記憶體與硬體系統、效率改善的輔助架構等小型專案，避免因專案規模擴大導致人員與開發框架功能缺失形成的人員訓練與軟體效能風險。

本專案將基於主要的兩個伺服器服務軟體 ( Nginx、Apache ) 作為 CGI 處理平台，並撰寫測試服務來完成以下功能：

+ Server side scripting
+ WebAPI

主要使用語言以 C++ / Perl

## Nginx

+ 啟用容器

```
dockerw nginx
```

+ 關閉容器

```
dockerw nginx --down
```

+ 進入容器並執行範例

```
dockerw nginx --into
perl <demo-filename>.pl
```

### 設定

Nginx 本身並不具備 CGI 相關服務，因此需使用 FastCGI 相關的套件來達成功能，本項目使用 fcgiwrap 套件，此套件會額外安裝 spawn-fcgi 與 fcgi 函式庫。

1. 安裝 fcgiwrap，```apt-get update && apt-get install -y fcgiwrap```
2. 撰寫 fcgiwrap 啟動腳本並放置於 ```/etc/init.d/fcgiwrap```
3. 執行 fcgiwrap 腳本，並確認產生 ```/tmp/cgi.sock```
4. 若 ```/tmp/cgi.sock``` 權限不足，需額外設定 ```chmod 777 /tmp/cgi.sock```
5. 撰寫 ```/etc/nginx/conf.d/default.conf```，增加 ```cgi-bin``` 路由，並經由 ```unix:/tmp/cgi.sock``` 進行 socket 通訊

Nginx 原理上是透過 Socket 與常駐執行的 FastCGI 套件通訊，並委請此服務執行 ```fastcgi_param SCRIPT_FILENAME``` 指向的目標檔案。

## Apache

+ 啟用容器

```
dockerw apache
```

+ 關閉容器

```
dockerw apache --down
```

+ 進入容器並執行範例

```
dockerw apache --into
perl <demo-filename>.pl
```

### 設定

1. 啟用 CGI 模組，確認 httpd.conf 中的 ```LoadModule cgid_module modules/mod_cgid.so``` 未被註解；啟動服務後可用 ```httpd -t -D DUMP_MODULES``` 確認
2. 指定 CGI 目錄，確認 httpd.conf 中的 ```ScriptAlias "/cgi-bin/" "/usr/local/apache2/cgi-bin/"``` 設定指向預期的目錄；在此設定中，```<path>/cgi-bin``` 下的內容都會被視為 CGI 程式來執行
3. 設定 CGI 可執行檔案，確認 httpd.conf 中的 mime_module 區段 ```AddHandler cgi-script .cgi .pl``` 有設定 ```*.cgi```  和 ```*.pl``` 有指定
4. 設定 CGI 操作選項，確認 httpd.conf 中的 ```<Directory "/usr/local/apache2/htdocs/somedir"> ... </Directory>``` 指定以下內容：
    + ```Option ExecCGI```，允許該目錄執行 CGI
    + ```SetHandler cgi-script```，使用 cgi-script 的副檔設定

## 驗證頁

+ [HTML 驗證](http://localhost/index.html)，確認服務啟動
    + for apache : [伺服器資訊](http://localhost/server-info)，開啟 mod_info
    + for apache : [伺服器狀態](http://localhost/server-status)，開啟 mode_status
+ [CGI 驗證](http://localhost/cgi-bin/index.cgi)，確認 CGI 啟動，執行簡單的 shell script
+ [CGI 驗證](http://localhost/cgi-bin/index.pl)，確認 CGI 啟動，執行簡單的 perl script
+ [取得環境資訊](http://localhost/cgi-bin/printenv.pl)

**需注意，若出現 500 錯誤，即可能是檔案操作權限不足 (775、777) 或此檔案解析錯誤，例如段行格式錯誤，LF 使用為 CRLF**

## 文獻

+ [Common Gateway Interface wiki](https://zh.wikipedia.org/zh-tw/%E9%80%9A%E7%94%A8%E7%BD%91%E5%85%B3%E6%8E%A5%E5%8F%A3)
    - [What is the Common Gateway interface (CGI)?](https://mixwithmarketing.com/2022/02/what-is-the-common-gateway-interface-cgi/)
+ Nginx
    - [NGINX : FCGI Wrap](https://www.nginx.com/resources/wiki/start/topics/examples/fcgiwrap/)
        + [fcgiwrap 的简单使用](https://blog.twofei.com/642/)
        + [FcgiWrap ubuntu](https://help.ubuntu.com/community/FcgiWrap)
    - [Nginx fastcgi、uwgi、scgi](https://www.796t.com/content/1546776782.html)
    - [nginx alpine run shell script](https://mac-blog.org.ua/docker-nginx-shell-script/)
    - [用 Nginx 搭配 fcgiwrap 執行 CGI 程式](https://opensourcedoc.com/web-programming/run-cgi-programs-with-fcgiwrap/)
    - [Nginx + CGI/FastCGI + C/Cpp](https://www.cnblogs.com/skynet/p/4173450.html)
    - [perl + fastcgi + nginx搭建](http://www.ttlsa.com/nginx/perl-fastcgi-nginx/)
    - [Nginx / uWSGI / Python 之關聯#2 : uWSGI篇](https://medium.com/bucketing/nginx-uwsgi-python-%E4%B9%8B%E9%97%9C%E8%81%AF-2-uwsgi%E7%AF%87-7b439ef028ec)
    - [Python CGI on Nginx](https://techexpert.tips/nginx/python-cgi-nginx/)
+ Apache2
    - Document
        + [Apache Tutorial: Dynamic Content with CGI](https://httpd.apache.org/docs/2.4/howto/cgi.html)
        + [How To Configure Apache 2](https://www3.ntu.edu.sg/home/ehchua/programming/howto/Apache_HowToConfigure.html)
        + [透過Docker架設Apache啟用CGI](https://r888800009.github.io/posts/cgi-apache/)
    - [Perl CGI編程](http://www.w3big.com/zh-TW/perl/perl-cgi-programming.html)
    - [Enable CGI and Use Perl Scripts](https://www.server-world.info/en/note?os=Ubuntu_16.04&p=httpd&f=2)
    - [Perl/CGI script with Apache2](https://perlmaven.com/perl-cgi-script-with-apache2)
+ [Fastcgi](https://fastcgi-archives.github.io/)
    - [用c++写一个 “hello,world” 的 FastCGI程序](https://www.cnblogs.com/oxspirt/p/5505184.html)
+ [Perl wiki](https://zh.wikipedia.org/zh-tw/Perl)
    - 語言
        + [Perl的基本語法](http://ind.ntou.edu.tw/~dada/cgi/Perlsynx.htm)
        + [Perl 教學 -- 函數與字串處理](http://web.nchu.edu.tw/~jlu/cyut/perl-functions.shtml)
        + [如何更改 @INC 來找到不位在標準目錄的 Perl 模組](https://tw.perlmaven.com/how-to-change-inc-to-find-perl-modules-in-non-standard-locations)
    - [函式庫 Metacpan](https://metacpan.org/)
        + [JSON](https://metacpan.org/pod/JSON#NAME)
