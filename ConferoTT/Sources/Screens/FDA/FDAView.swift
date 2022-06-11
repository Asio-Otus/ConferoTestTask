import SwiftUI

struct FDAView: View {
	@ObservedObject var vm: FDAVM

    var body: some View {
		VStack {
			FDALimitSelectorView(limit: $vm.currentLimit)

			List {
				switch vm.fdaModels {
				case .initial:
					Text("Not initialized")

				case .processing:
					ProgressView()
						.progressViewStyle(.circular)

				case .completed(let models):
					ForEach(models, id: \.eventId) { model in
						Text(model.productDecription)
					}


				case .failed(let error):
					VStack {
						Text("Error")
						Text(error.localizedDescription)
					}
				}
			}
		}
    }
}

extension FDAView {
	func onLimitButtonTouched (_ limit: Int) {
		vm.load(limit)
	}
}

struct FDAView_Previews: PreviewProvider {
    static var previews: some View {
		FDAView(vm: FDAVM())
    }
}
