library zefyr_quill_convert;

/// Converts a list of zefyr deltas (usually decoded from JSON) to a list of
/// flutter_quill deltas.
List<Map<String, dynamic>> toQuillData(List zefyrData) {
  List<Map<String, dynamic>> quillData = [];
  zefyrData.forEach((zefyrDelta) {
    Map<String, dynamic> quillDelta = {};
    if (zefyrDelta.containsKey('insert')) {
      quillDelta['insert'] = zefyrDelta['insert'];
    }
    if (zefyrDelta.containsKey('attributes')) {
      quillDelta['attributes'] =
          _toQuillAttributes(zefyrDelta['attributes'] as Map);
    }
    if (quillDelta.isNotEmpty) {
      quillData.add(quillDelta);
    }
  });
  return quillData;
}

Map<String, dynamic> _toQuillAttributes(Map zefyrAttribute) {
  Map<String, dynamic> quillAttr = {};
  if (zefyrAttribute.containsKey('b')) {
    quillAttr['bold'] = zefyrAttribute['b'];
  }
  if (zefyrAttribute.containsKey('i')) {
    quillAttr['italic'] = zefyrAttribute['i'];
  }
  if (zefyrAttribute.containsKey('heading')) {
    quillAttr['header'] = zefyrAttribute['heading'];
  }
  if (zefyrAttribute.containsKey('s')) {
    quillAttr['strike'] = zefyrAttribute['s'];
  }
  if (zefyrAttribute.containsKey('a')) {
    quillAttr['link'] = zefyrAttribute['a'];
  }
  if (zefyrAttribute.containsKey('block')) {
    if (zefyrAttribute['block'] == 'ul') {
      quillAttr['list'] = 'bullet';
    }
    if (zefyrAttribute['block'] == 'ol') {
      quillAttr['list'] = 'ordered';
    }
    if (zefyrAttribute['block'] == 'quote') {
      quillAttr['blockquote'] = true;
    }
    if (zefyrAttribute['block'] == 'code') {
      quillAttr['code-block'] = true;
    }
  }
  if (zefyrAttribute.containsKey('embed')) {
    Map embed = zefyrAttribute['embed'] as Map;
    if (embed['type'] == 'image') {
      quillAttr['image'] = embed['source'];
    }
  }
  return quillAttr;
}
