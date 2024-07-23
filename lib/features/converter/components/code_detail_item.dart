import 'package:flutter/material.dart';
import 'package:flutter_coder/features/shared/utils/extensions.dart';

import '../models/code_detail.dart';

class CodeDetailItem extends StatelessWidget {
  final CodeDetail? currentDetail;
  final List<CodeDetail> codeDetails;
  final int index;
  final int? parentIndex;
  final void Function(List<CodeDetail> codeDetails, int index, int? parentIndex)
      onRemove;
  final void Function(List<CodeDetail> codeDetails, int? parentIndex) onAdd;
  final void Function(List<CodeDetail> codeDetails, int index, int? parentIndex)
      onSelect;
  const CodeDetailItem(
      {super.key,
      required this.codeDetails,
      required this.index,
      this.parentIndex,
      required this.onRemove,
      required this.onAdd,
      required this.onSelect,
      this.currentDetail});

  @override
  Widget build(BuildContext context) {
    final details = parentIndex != null
        ? codeDetails[parentIndex!].childrenCodeDetails
        : codeDetails;
    final detail = details[index];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () => onSelect(codeDetails, index, parentIndex),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: currentDetail?.id == detail.id ? Colors.purple : null),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              key: Key(detail.id),
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "${detail.type} $index",
                    style: context.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () => onAdd(details, index),
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () => onRemove(codeDetails, index, parentIndex),
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
          ),
        ),
        if (detail.childrenCodeDetails.isNotEmpty) ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 10, left: 20),
            itemCount: detail.childrenCodeDetails.length,
            itemBuilder: (context, childindex) {
              return CodeDetailItem(
                currentDetail: currentDetail,
                codeDetails: details,
                index: childindex,
                parentIndex: index,
                onRemove: onRemove,
                onAdd: onAdd,
                onSelect: onSelect,
              );
            },
          ),
        ]
      ],
    );
  }
}
