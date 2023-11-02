import React from 'react';

const PdfPreview = ({ src }) => (
  <object data={src} type="application/pdf"></object>
);

export default PdfPreview;
