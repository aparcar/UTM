//
// Copyright © 2020 osy. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI

@available(iOS 14, macOS 11, *)
struct VMConfigPortForwardForm: View {
    @ObservedObject var configPort: UTMQemuConfigurationPortForward
    
    var body: some View {
        Group {
            VMConfigStringPicker("Protocol", selection: $configPort.protocol, rawValues: ["tcp", "udp"], displayValues: ["TCP", "UDP"])
            DefaultTextField("Guest Address", text: $configPort.guestAddress, prompt: "10.0.2.15")
            NumberTextField("Guest Port", number: $configPort.guestPort, prompt: "1234")
            DefaultTextField("Host Address", text: $configPort.hostAddress, prompt: "127.0.0.1")
            NumberTextField("Host Port", number: $configPort.hostPort, prompt: "1234")
        }.disableAutocorrection(true)
        .keyboardType(.decimalPad)
    }
}

@available(iOS 14, macOS 11, *)
struct VMConfigPortForwardForm_Previews: PreviewProvider {
    @State static private var config = UTMQemuConfiguration()
    @State static private var configPort = UTMQemuConfigurationPortForward()
    
    static var previews: some View {
        VStack {
            VStack {
                Form {
                    VMConfigPortForwardForm(configPort: configPort)
                }
            }
        }.onAppear {
            if config.countPortForwards == 0 {
                let newConfigPort = UTMQemuConfigurationPortForward()
                newConfigPort.protocol = "tcp"
                newConfigPort.guestAddress = "1.2.3.4"
                newConfigPort.guestPort = 1234
                newConfigPort.hostAddress = "4.3.2.1"
                newConfigPort.hostPort = 4321
                config.newPortForward(newConfigPort)
                newConfigPort.protocol = "udp"
                newConfigPort.guestAddress = ""
                newConfigPort.guestPort = 2222
                newConfigPort.hostAddress = ""
                newConfigPort.hostPort = 3333
                config.newPortForward(newConfigPort)
            }
        }
    }
}
