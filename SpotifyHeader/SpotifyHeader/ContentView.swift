//
//  ContentView.swift
//  SpotifyHeader
//
//  Created by Shreyas Vilaschandra Bhike on 02/12/24.
//

//  MARK: Instagram
//  TheAppWizard
//  MARK: theappwizard2408

import SwiftUI
import Combine


struct ContentView: View {
    var body: some View {
        FinalView()
    }
}

#Preview {
    ContentView()
}




















struct FinalView: View {
    @State private var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State private var showHeader = false

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.edgesIgnoringSafeArea(.all)

            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HeaderView(showHeader: $showHeader, time: time)
                    DetailsView()
                }
            }

            if showHeader {
                TopView()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct HeaderView: View {
    @Binding var showHeader: Bool
    let time: Publishers.Autoconnect<Timer.TimerPublisher>

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("image2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 35))

                Text("Shakira")
                    .font(.system(size: 60, weight: .semibold))
                    .foregroundColor(.white)
                    .offset(y: 200)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY : 0)
            .frame(height: max(UIScreen.main.bounds.height / 2.2, geometry.frame(in: .global).minY + UIScreen.main.bounds.height / 2.2))
            .onReceive(time) { _ in
                let yOffset = geometry.frame(in: .global).minY
                showHeader = -yOffset > UIScreen.main.bounds.height / 2.2 - 50
            }
        }
        .frame(height: UIScreen.main.bounds.height / 2.2)
    }
}

struct DetailsView: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("33,727,103 monthly listeners")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(.white.opacity(0.6))

                    FollowButton()
                }

                Spacer()

                PlayButton()
            }
            .padding()

            ForEach(data) { item in
                CardView(data: item)
            }
        }
    }
}

struct FollowButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.white, lineWidth: 1)
                .frame(width: 130, height: 35)

            Text("FOLLOW")
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
        }
    }
}

struct PlayButton: View {
    var body: some View {
        Button(action: {}) {
            ZStack {
                Circle()
                    .stroke(Color.green, lineWidth: 4)
                    .frame(width: 80, height: 80)

                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.green)
            }
        }
    }
}

struct CardView: View {
    var data: Card
    @State private var isLiked = false

    var body: some View {
        HStack(spacing: 20) {
            Image(data.image)
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 6) {
                Text(data.title)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(data.subTitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }

            Spacer()

            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5)) {
                    isLiked.toggle()
                }
            }) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .foregroundColor(isLiked ? .green : .green)
                    .scaleEffect(isLiked ? 1.2 : 1.0)
            }
        }
        .padding(.horizontal)
    }
}


struct TopView: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 14, height: 22)
                .foregroundColor(.white)

            Spacer()

            Text("Shakira")
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
                .offset(x:10)

            Spacer()

            Text("Play")
                .foregroundColor(.white)
                .font(.title2)
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 30)
        .padding(.horizontal)
        .padding(.bottom)
        .background(Color.brown)
    }
}

struct Card: Identifiable {
    var id: Int
    var image: String
    var title: String
    var subTitle: String
}

let data = [
    Card(id: 0, image: "1", title: "Hips Don't Lie (feat. Wycl..", subTitle: "957,512,242"),
    Card(id: 1, image: "2", title: "GIRL LIKE ME", subTitle: "368,233,618"),
    Card(id: 2, image: "3", title: "Waka Waka (This Time for Africa)", subTitle: "502,716,844"),
    Card(id: 3, image: "4", title: "Chantaje (feat. Maluma)", subTitle: "502,716,844"),
    Card(id: 4, image: "5", title: "Whenever, Wherever", subTitle: "502,716,844"),
    Card(id: 0, image: "1", title: "Hips Don't Lie (feat. Wycl..", subTitle: "957,512,242"),
    Card(id: 1, image: "2", title: "GIRL LIKE ME", subTitle: "368,233,618"),
    Card(id: 2, image: "3", title: "Waka Waka (This Time for Africa)", subTitle: "502,716,844"),
    Card(id: 3, image: "4", title: "Chantaje (feat. Maluma)", subTitle: "502,716,844"),
    Card(id: 4, image: "5", title: "Whenever, Wherever", subTitle: "502,716,844")
]
