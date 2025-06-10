import SwiftUI

struct MessagesView: View {
    var body: some View {
        NavigationView {
            Text("消息")
                .navigationTitle("消息")
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
