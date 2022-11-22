//
//  FileImageVideo.swift
//  create archives
//
//  Created by Кирилл on 26.10.2022.
//

import Foundation
import SwiftUI

struct FileImageVideo: View{
    @Binding var editing: Bool
    @Binding var itemsSwitchON: [ObjectArchive]
    @State var switchON = false
    var item: ObjectArchive
    
    func toShare(s: String){
        let newUrl = URL(string: "file://" + s)
        let activityVC = UIActivityViewController(activityItems: [newUrl], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }

    var whiteRound: some View{
        ZStack{
            Circle()
                .strokeBorder(Color.white, lineWidth: 1.5)
                .frame(width: UIScreen.sW * 0.05, height: UIScreen.sW * 0.05)
                if (switchON)
                {
                    Circle()
                        .fill(Color.white)
                        .frame(width: UIScreen.sW * 0.034, height: UIScreen.sW * 0.034)
                }
        }
        .padding(.trailing, 12)
        .onTapGesture {
            if (editing)
            {
                switchON.toggle()
            }
        }
    }

    var body: some View{
        HStack{
            switch item.type{
                case "v": Image("vid")
                    .resizable()
                    .frame(width: UIScreen.sW * 0.1, height: UIScreen.sW * 0.1, alignment: .center)
                    .padding(.leading)
                case "i": Image("img")
                    .resizable()
                    .frame(width: UIScreen.sW * 0.1, height: UIScreen.sW * 0.1, alignment: .center)
                    .padding(.leading)
                case "f": Image("file")
                    .resizable()
                    .frame(width: UIScreen.sW * 0.1, height: UIScreen.sW * 0.1, alignment: .center)
                    .padding(.leading)
                case "a": Image("zip")
                    .resizable()
                    .frame(width: UIScreen.sW * 0.1, height: UIScreen.sW * 0.1, alignment: .center)
                    .padding(.leading)
                default: Image("file")
                    .resizable()
                    .frame(width: UIScreen.sW * 0.1, height: UIScreen.sW * 0.1, alignment: .center)
                    .padding(.leading)
            }
            VStack(alignment: .leading){
                Text(item.name!)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color.white)
                Text(URL(string: "file://" + item.data!)!.fSString)
                    .font(.system(size: 15))
                    .foregroundColor(Color("text1"))

            }
            
            Spacer()
            
            VStack(alignment: .trailing){
                if (editing)
                {
                    whiteRound
                }
                else
                {
                    Button(action:{toShare(s: item.data!)})
                    {
                        Image("more")
                    }
                    .padding(.trailing, 12)
                }
                Text((item.day?.timeAgoDisplay())!)
                    .font(.system(size: 15))
                    .foregroundColor(Color("text1"))
                    .padding(.trailing, 12)
            }
        }
        .frame(width: UIScreen.sW * 0.95, height: UIScreen.sH * 0.07, alignment: .center)
        .background(switchON && editing ? Color(red: 0.4, green: 0.29, blue: 1) : Color(red: 0.2, green: 0.2, blue: 0.247))
        .cornerRadius(15)
        .onTapGesture {
            switchON.toggle()
            if (switchON)
            {
                itemsSwitchON.append(item)
            }
            else if (!switchON)
            {
                itemsSwitchON = itemsSwitchON.filter{ $0 != item}
            }
        }
    }
}
