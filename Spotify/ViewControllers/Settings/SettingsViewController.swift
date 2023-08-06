//
//  SettingsViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

class SettingsViewController: UIViewController {
    var viewModel: SettingsViewModel!
    @IBOutlet weak var tableView: UITableView!
    private var sections = [SettingsSection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setupTableView()
        configureSections()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func configureSections() {
        sections.append(
            SettingsSection(
                title: Strings.profile,
                options: [
                    Option(
                        text: Strings.viewProfile,
                        handler: { [weak self] in
                            DispatchQueue.main.async {
                                self?.viewProfile()
                            }
                        },
                        image: "person.fill"
                    )
                ]
            ))

        sections.append(
            SettingsSection(
                title: Strings.account,
                options: [
                    Option(
                        text: Strings.logout,
                        handler: { [weak self] in
                            DispatchQueue.main.async {
                                self?.logout()
                            }
                        },
                        image: "power"
                    )
                ]
            ))
    }

    private func viewProfile() {
        let viewModel = viewModel.getProfileViewModel()
        let viewController = UIViewController.profileViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func logout() {
//        viewModel.signout
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = sections[indexPath.section].options[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: row.image)
        content.text = row.text
        content.textProperties.color = .white
        content.imageProperties.tintColor = .white
        cell.contentConfiguration = content

        cell.backgroundColor = .black
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].options[indexPath.row].handler()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
}
