let $path := '/Volumes/data/github/anrCondorcet/tools/temp/photos/'
for $type in file:list($path)
return (
  if(file:is-dir($path || $type) = true()) then (
    let $docType := fn:substring-before($type, '/')
    return (
     $docType,
     for $doc in file:list($path || $type) 
     return 
     if(file:is-dir($path || $type || $doc) = true()) then (
       for $img at $i in file:list($path || $type || $doc)
       let $extension := fn:substring-after($img, '.')
       let $pagination := fn:format-number($i, '0000')
       return (file:move($path || $type || $doc || $img, $path || $type || $doc || $docType || fn:substring-before($doc, '/') || '_p' || $pagination || '.' || $extension),
       $path || $type || $doc || $img,
       
       $path || $type || $doc || $docType || fn:substring-before($doc, '/') || '_p' || $pagination || '.' || $extension)
     )
    )
  )
  
)