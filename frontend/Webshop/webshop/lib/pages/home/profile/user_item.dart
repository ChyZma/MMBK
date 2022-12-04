// import 'package:flutter/material.dart';
//
// import '../../../models/user.dart';
//
// class UserItem extends StatelessWidget {
//   final User merchant;
//   final bool hasBankAccount;
//   final VoidCallback onMerchantOptIn;
//
//   const UserItem({
//     super.key,
//     required this.merchant,
//     required this.hasBankAccount,
//     required this.onMerchantOptIn,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(minHeight: 88),
//       decoration: const BoxDecoration(
//         color: ColorPalette.white,
//         borderRadius: BorderRadius.all(Radius.circular(radius)),
//         boxShadow: Shadows.light,
//       ),
//       child: Ripple(
//         radiusSize: radius,
//         onTap: () {
//           IoC.navigation.openMerchantDetails(merchant.id);
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(Sizes.small),
//               child: CashbackItemImage.merchant(imageUrl: merchant.imageUrl),
//             ),
//             Expanded(
//               child: Column(
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 12.0),
//                           child: Text(
//                             merchant.name,
//                             style: Fonts.bodyRegular.bold.copyWith(
//                               color: ColorPalette.blueDark,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Hgap.small(),
//                       OfferFlags(offers: merchant.offers, gap: 4),
//                       const Hgap(Sizes.radius),
//                     ],
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Flexible(
//                         child: OfferText(
//                           merchant: merchant,
//                           hasBankAccount: hasBankAccount,
//                         ),
//                       ),
//                       Hgap.small(),
//                       if (merchant.isOptInOfferInactive && hasBankAccount)
//                         SmallButton(
//                           text: context.l10n('common_activate'),
//                           onTap: onMerchantOptIn,
//                         ),
//                       Hgap.small(),
//                     ],
//                   ),
//                   Vgap.small(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
