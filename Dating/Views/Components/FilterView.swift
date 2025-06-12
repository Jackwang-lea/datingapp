import SwiftUI

struct FilterView: View {
    @Binding var selectedEducation: Education?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("学历要求")) {
                    Picker("学历", selection: $selectedEducation) {
                        Text("不限").tag(Education?.none)
                        ForEach(Education.allCases) { education in
                            Text(education.rawValue).tag(Optional(education))
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
                }
            }
            .navigationTitle("筛选条件")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("重置") {
                        selectedEducation = nil
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("完成") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    FilterView(selectedEducation: .constant(nil))
}
