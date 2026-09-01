//
//  ViewController.swift
//  ZhetianIOS
//
//  Created by Trae on 2026/9/2.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    let gameURL = "http://155.103.156.139:81/index.html"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide navigation bar for fullscreen game experience
        navigationController?.setNavigationBarHidden(true, animated: false)

        // Configure WKWebView
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []

        webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        webView.allowsBackForwardNavigationGestures = false

        view.addSubview(webView)

        // Show loading indicator
        showLoading()

        if let url = URL(string: gameURL) {
            let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
            webView.load(request)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Loading

    private func showLoading() {
        let loadingView = UIView(frame: view.bounds)
        loadingView.tag = 999
        loadingView.backgroundColor = UIColor.black

        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        spinner.startAnimating()
        loadingView.addSubview(spinner)

        view.addSubview(loadingView)
    }

    private func hideLoading() {
        if let loadingView = view.viewWithTag(999) {
            UIView.animate(withDuration: 0.3, animations: {
                loadingView.alpha = 0
            }) { _ in
                loadingView.removeFromSuperview()
            }
        }
    }

    // MARK: - WKNavigationDelegate

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoading()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideLoading()
        showError(message: "加载失败，请检查网络连接")
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        hideLoading()
        showError(message: "网络连接异常")
    }

    private func showError(message: String) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "重试", style: .default, handler: { _ in
            if let url = URL(string: self.gameURL) {
                self.webView.load(URLRequest(url: url))
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}
