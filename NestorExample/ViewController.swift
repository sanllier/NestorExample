//
//  ViewController.swift
//  NestorExample
//
//  Created by Alexander Goremykin on 06.06.17.
//  Copyright © 2017 Alexander Goremykin. All rights reserved.
//

import UIKit
import YandexMobileTestCaseRecorder

class ViewController: UIViewController {

    struct Static {
        static let uuid = "uuid_here"
        static let validationUrl = URL(string: "http://www.google.com")!
        static let validationToken = "token"
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        testCaseRecordingController.addListener(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(startStopButton)

        startStopButton.setTitle("TAP ME", for: .normal)
        startStopButton.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
        startStopButton.translatesAutoresizingMaskIntoConstraints = false
        startStopButton.backgroundColor = .green

        view.addConstraint(NSLayoutConstraint(item: startStopButton, attribute: .width, relatedBy: .equal,
                                              toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80.0))
        view.addConstraint(NSLayoutConstraint(item: startStopButton, attribute: .height, relatedBy: .equal,
                                              toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80.0))

        view.addConstraint(NSLayoutConstraint(item: startStopButton, attribute: .centerX, relatedBy: .equal,
                                              toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: startStopButton, attribute: .centerY, relatedBy: .equal,
                                              toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0))

        testCaseRecordingBarController = TCRStatusBarController(container: view, controller: testCaseRecordingController)
    }

    func handleButtonTap(_ sender: UIButton) {
        switch testCaseRecordingController.state {
        case .idle: testCaseRecordingController.runWithAlertPrompt()
        case .recording: testCaseRecordingController.stopCurrentTestCase()
        case .completion, .completionError: break
        }
    }

    fileprivate let startStopButton = UIButton()
    fileprivate let testCaseRecordingController = TCRController(uuid: Static.uuid,
                                                                validationURL: Static.validationUrl,
                                                                validationToken: Static.validationToken)
    fileprivate var testCaseRecordingBarController: TCRStatusBarController?

}

extension ViewController: TCRControllerListener {

    func testCaseRecordingController(_ recordingController: TCRController, didChangeState state: TCRControllerState) {
        switch state {
        case .idle: startStopButton.backgroundColor = .green
        case .recording: startStopButton.backgroundColor = .red
        case .completion, .completionError: startStopButton.backgroundColor = .yellow
        }
    }

}
