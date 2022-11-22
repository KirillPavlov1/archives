//
//  add.swift
//  create archives
//
//  Created by Кирилл on 25.10.2022.
//

import Foundation
import SwiftUI

struct addView: View{
    
    @Binding var isVis: Bool
    @State var videos = false
    @State var images = false
    @State var files = false
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View{
        ZStack{
            Rectangle()
                .fill(Color.black.opacity(0.6))
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Button(action:{images = true}){
                    Image("add2")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                }
                .sheet(isPresented: $images, onDismiss: {}) {
                    ImagePicker(show: $images)
                        .environment(\.managedObjectContext, viewContext)
                }
                Button(action:{files = true}){
                    Image("add3")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                }
                .sheet(isPresented: $files, onDismiss: {})
                {
                    FilePicker()
                        .environment(\.managedObjectContext, viewContext)
                }
                Button(action:{videos = true}){
                    Image("add5")
                        .scaleEffect(UIScreen.sH / UIScreen.sW * 0.5)
                        .padding(.bottom)
                }
                .sheet(isPresented: $videos, onDismiss: {})
                {
                    VideosPicker(show: $videos)
                        .environment(\.managedObjectContext, viewContext)
                }
                Button(action:{isVis = false}){
                    Image("add4")
                        .padding(.vertical)
                }
            }
        }
    }
}

struct add_Previews: PreviewProvider {
    static var previews: some View {
        addView(isVis: .constant(true))
    }
}
