function __fish_complete_docutils --description 'Completions for Docutils common options' --argument cmd
    complete -x -c $cmd -k -a "(__fish_complete_suffix .rst .txt)"

    # General Docutils Options
    complete -c $cmd -l title -d "Specify the docs title"
    complete -c $cmd -s g -l generator -d "Include a generator credit"
    complete -c $cmd -l no-generator -d "Don't include a generator credit"
    complete -c $cmd -s d -l date -d "Include the date at the end of the docs"
    complete -c $cmd -s t -l time -d "Include the time and date"
    complete -c $cmd -l no-datestamp -d "Don't include a datestamp"
    complete -c $cmd -s s -l source-link -d "Include a source link"
    complete -c $cmd -l source-url -d "Use URL for a source link"
    complete -c $cmd -l no-source-link -d "Don't include a source link"
    complete -c $cmd -l toc-entry-backlinks -d "Link from section headers to TOC entries"
    complete -c $cmd -l toc-top-backlinks -d "Link from section headers to the top of the TOC"
    complete -c $cmd -l no-toc-backlinks -d "Disable backlinks to the TOC"
    complete -c $cmd -l footnote-backlinks -d "Link from footnotes/citations to references"
    complete -c $cmd -l no-footnote-backlinks -d "Disable backlinks from footnotes/citations"
    complete -c $cmd -l section-numbering -d "Enable section numbering"
    complete -c $cmd -l no-section-numbering -d "Disable section numbering"
    complete -c $cmd -l strip-comments -d "Remove comment elements"
    complete -c $cmd -l leave-comments -d "Leave comment elements"
    complete -c $cmd -l strip-elements-with-class -d "Remove all elements with classes"
    complete -c $cmd -l strip-class -d "Remove all classes attributes"
    complete -x -c $cmd -s r -l report -a "info warning error severe none 1 2 3 4 5" -d "Report system messages"
    complete -c $cmd -s v -l verbose -d "Report all system messages"
    complete -c $cmd -s q -l quiet -d "Report no system messages"
    complete -x -c $cmd -l halt -a "info warning error severe none 1 2 3 4 5" -d "Halt execution at system messages"
    complete -c $cmd -l strict -d "Halt at the slightest problem"
    complete -x -c $cmd -l exit-status -a "info warning error severe none 1 2 3 4 5" -d "Enable a non-zero exit status"
    complete -c $cmd -l debug -d "Enable debug output"
    complete -c $cmd -l no-debug -d "Disable debug output"
    complete -c $cmd -l warnings -d "File to output system messages"
    complete -c $cmd -l traceback -d "Enable Python tracebacks"
    complete -c $cmd -l no-traceback -d "Disable Python tracebacks"
    complete -c $cmd -s i -l input-encoding -d "Encoding of input text"
    complete -x -c $cmd -l input-encoding-error-handler -a "strict ignore replace" -d "Error handler"
    complete -c $cmd -s o -l output-encoding -d "Encoding for output"
    complete -x -c $cmd -l output-encoding-error-handler -a "strict ignore replace xmlcharrefreplace backslashreplace" -d "Error handler"
    complete -c $cmd -s e -l error-encoding -d "Encoding for error output"
    complete -x -c $cmd -l error-encoding-error-handler -d "Error handler"
    complete -c $cmd -s l -l language -d "Specify the language"
    complete -c $cmd -l record-dependencies -d "File to write output file dependencies"
    complete -c $cmd -l config -d "File to read configs"
    complete -c $cmd -s V -l version -d "Show version number"
    complete -c $cmd -s h -l help -d "Show help message"

    # reStructuredText Parser Options
    complete -c $cmd -l pep-references -d "Link to standalone PEP refs"
    complete -c $cmd -l pep-base-url -d "Base URL for PEP refs"
    complete -c $cmd -l pep-file-url-template -d "Template for PEP file part of URL"
    complete -c $cmd -l rfc-references -d "Link to standalone RFC refs"
    complete -c $cmd -l rfc-base-url -d "Base URL for RFC refs"
    complete -c $cmd -l tab-width -d "Specify tab width"
    complete -c $cmd -l trim-footnote-reference-space -d "Remove spaces before footnote refs"
    complete -c $cmd -l leave-footnote-reference-space -d "Leave spaces before footnote refs"
    complete -c $cmd -l no-file-insertion -d "Disable directives to insert file"
    complete -c $cmd -l file-insertion-enabled -d "Enable directives to insert file"
    complete -c $cmd -l no-raw -d "Disable the 'raw' directives"
    complete -c $cmd -l raw-enabled -d "Enable the 'raw' directives"
    complete -x -c $cmd -l syntax-highlight -a "long short none" -d "Token name set for Pygments"
    complete -x -c $cmd -l smart-quotes -a "yes no alt" -d "Change straight quotation marks"
    complete -c $cmd -l smartquotes-locales -d "'smart quotes' for the language"
    complete -c $cmd -l word-level-inline-markup -d "Inline markup at word level"
    complete -c $cmd -l character-level-inline-markup -d "Inline markup at character level"
end
