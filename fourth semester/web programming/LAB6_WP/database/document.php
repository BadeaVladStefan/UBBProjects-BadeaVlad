<?php

class Document{
    public $id;
    public $title;
    public $author;
    public $numberPages;
    public $type;
    public $format;


    function __construct($id, $title, $author, $numberPages, $type, $format)
    {
        $this->id = $id;
        $this->title = $title;
        $this->author = $author;
        $this->numberPages = $numberPages;
        $this->type = $type;
        $this->format = $format;        
    }

}
