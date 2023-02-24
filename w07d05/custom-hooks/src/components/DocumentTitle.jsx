import useDocumentTitle from "../hooks/useDocumentTitle";

const DocumentTitle = () => {
  const title = 'final sale! everything must go!';

  useDocumentTitle(title);

  // useEffect(() => {
  //   document.title = title;
  // }, [title]);

  return (
    <div>
      <h2>DocumentTitle component</h2>
    </div>
  );
};

export default DocumentTitle;
