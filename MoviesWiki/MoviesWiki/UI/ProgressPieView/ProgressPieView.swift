import SwiftUI

struct ProgressPieView: View {
    @Binding var progress: Float

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black)
                .opacity(0.6)

            Circle()
                .stroke(lineWidth: 5.0)
                .opacity(0.5)
                .foregroundColor(Color.green)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: 1)

            Text(String(format: "%.0f %%", min(self.progress, 1.0) * 100.0))
                .font(.footnote)
                .foregroundColor(.white)
        }
    }
}

struct ProgressPieView_Previews: PreviewProvider {

    @State static var value: Float = 0.6

    static var previews: some View {
        ProgressPieView(progress: $value)
    }
}
