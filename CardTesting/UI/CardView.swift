//
//  Copyright © 2020 Don Mowry
//

import SwiftUI

struct CardView: View, Animatable {
    @State var degrees: Double = 0.0
    
    var isTranslationShowing: Bool {
        degrees >= 90.0
    }
    
    var animatableData: Double {
        get { degrees }
        set { degrees = newValue }
    }
    
    let card: Card
    
    var body: some View {
        GeometryReader { geometry in
            self.content(with: geometry)
        }
        
    }
    
    private func content(with geometry: GeometryProxy) -> some View {
        ZStack(alignment: .center) {
            CardFace(title: card.titles.string(forLocale: "en"),
                     imageName: card.imageInformation.id,
                     color: UIColor(named: "CardColorFront") ?? .blue)
                .opacity(isTranslationShowing ? 0.0 : 1.0)
                .accessibility(hidden: isTranslationShowing)
                .frame(width: geometry.size.width,
                       height: geometry.size.width,
                       alignment: .center)
            CardFace(title: card.titles.string(forLocale: "ga"),
                     imageName: card.imageInformation.id,
                     color: UIColor(named: "CardColorBack") ?? .yellow)
                .frame(width: geometry.size.width,
                       height: geometry.size.width,
                       alignment: .center)
                .accessibility(hidden: !isTranslationShowing)
                .rotation3DEffect(Angle(degrees: 180.0),
                                  axis: (0, 1, 0))
                .opacity(isTranslationShowing ? 1.0 : 0.0)
        }
        .rotation3DEffect(Angle(degrees: degrees),
                          axis: (0, 1, 0))
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.6)) {
                self.degrees = self.isTranslationShowing ? 0.0 : 180.0
            }
        }
    }
}

struct CardFace: View {
    
    private struct Constants {
        static let cornerRadius: CGFloat = 10.0
        static let edgeLineWidth: CGFloat = 1.0
    }
    
    let title: String?
    let imageName: String
    let color: UIColor
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(Constants.cornerRadius)
            Spacer()
            Text(title ?? "")
                .font(.headline)
                .fixedSize()
                .padding()
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(Constants.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .stroke(Color.gray, lineWidth: Constants.edgeLineWidth)
            )
            
        }
        .padding()
        .background(Color(color).cornerRadius(Constants.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(lineWidth: Constants.edgeLineWidth)
        )
        .accessibilityElement(children: .ignore)
        .accessibility(identifier: title ?? "")
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card: Card(id: "example",
                                titles: ["en": "EnglishTitle", "ga": "IrishTitle"],
                                imageInformation: ImageInformation(id: "home_image",
                                                                   sourceURL: nil,
                                                                   attribution: nil)))
            CardView(card: Card(id: "example",
                                titles: ["en": "EnglishTitle", "ga": "IrishTitle"],
                                imageInformation: ImageInformation(id: "home_image",
                                                                   sourceURL: nil,
                                                                   attribution: nil)))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
        }
    }
}
