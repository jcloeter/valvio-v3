import React from 'react';

const style = {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
};

const IconAndTextWrapper: React.FC<{ children: JSX.Element }> = (props) => {
    return <div style={style}>{props.children}</div>;
};

export default IconAndTextWrapper;
