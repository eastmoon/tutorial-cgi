# CGI ( Common Gateway Interface )

通用閘道器介面 ( Common Gateway Interface ) 是為提供網路服務內容而執行控制台應用 (或稱命令列介面）的程式，以達到伺服器上實現動態網頁的通用協定；通常情況下，一次請求對應一個 CGI 指令的執行，並對等生成一個 HTML 作為回應。

![Common Gateway Interface work flow](https://mixwithmarketing.com/wp-content/uploads/2022/02/Common-Gateway-Interface.png)

在 [Server side scripting](https://en.wikipedia.org/wiki/Server-side_scripting) 的歷史演進說明裡，在 CGI 推出的 1993 年後，1994 年網景 ( Netscape ) 推出了一套基於 JavaScript 的伺服器端腳本，而其設計目的是要以腳本方式替代 CGI 中採用 C / C++ / Perl 這類由作業系統執行的語言，並讓腳本受到伺服器服務的管理；可以理解為是避免開發人員，因使用作業系統層級的指令導致如錯誤記憶體配置等，嚴重可使系統崩潰的錯誤。

在此之後，伺服器端腳本逐一發展，即後續常見的 ASP、PHP、JSP 等多樣的伺服器端腳本；其後，前後端分離，從伺服器端腳本中抽離 HTML 產生交由前端框架，以 RestFul 為標準的建立 WebAPI 框架；直到最年的 Server side rendering ( SSR )，將 JavaScript 的 Rendering 框架交由後端處理，減輕瀏覽器在第一次繪製的處理耗損。

跟隨歷史的演進來看，CGI 本身即是最原始且靈活伺服器端腳本，亦可根據其設計需要選擇效率更高的作業系統語言，以此達成 Server side scripting 或 Server side rendering；但需注意，這樣的設計應考量在受限記憶體與硬體系統、效率改善的輔助架構等小型專案，避免因專案規模擴大導致人員與開發框架功能缺失形成的人員訓練與軟體效能風險。

## 文獻

+ [Common Gateway Interface wiki](https://zh.wikipedia.org/zh-tw/%E9%80%9A%E7%94%A8%E7%BD%91%E5%85%B3%E6%8E%A5%E5%8F%A3)
    - [What is the Common Gateway interface (CGI)?](https://mixwithmarketing.com/2022/02/what-is-the-common-gateway-interface-cgi/)
