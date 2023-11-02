import React, { useState } from 'react';
import { useField } from 'formik';

const FieldFileInput = ({ classes, name, ...rest }) => {
  const {
    fileUploadContainer,
    labelClass,
    fileNameClass,
    fileInput,
    previewImage,
  } = classes;
  const [{ value, ...restFields }, meta, helpers] = useField(name);
  const getFileName = () => {
    if (value) {
      return value.name;
    }
    return '';
  };

  const [previewURL, setPreviewURL] = useState(null);

  const handleFileChange = (e) => {
    const file = e.target.files[0];

    if (file) {
      helpers.setValue(file);

      const reader = new FileReader();
      reader.onload = () => {
        setPreviewURL(reader.result);
      };
      reader.readAsDataURL(file);
    } else {
      helpers.setValue(null);
      setPreviewURL(null);
    }
  };

  const imageStyles = {
    width: '120px',
    height: '120px',
    alignSelf: 'center',
  };

  return (
    <div className={fileUploadContainer}>
      <label htmlFor="fileInput" className={labelClass}>
        Choose file
      </label>
      <span id="fileNameContainer" className={fileNameClass}>
        {getFileName()}
      </span>
      <input
        {...restFields}
        onChange={handleFileChange}
        className={fileInput}
        id="fileInput"
        type="file"
      />
      {previewURL && (
        <img
          src={previewURL}
          alt="Preview"
          style={imageStyles}
          className={previewImage}
        />
      )}
    </div>
  );
};

export default FieldFileInput;
