import SwiftUI

struct FDALimitSelectorView: View {
	@Binding var limit: AllowedFDALimits

	var body: some View {
		HStack(spacing: 20) {
			ForEach(AllowedFDALimits.allCases, id: \.self) { limit in
				Button(
					action: { self.limit = limit },
					label: {
						Text(limit.description)
							.font(.system(size: 30))
							.foregroundColor(
								self.limit == limit
									? .blue
									: Color(UIColor.label)
							)
					}
				)
			}
		}
	}
}
