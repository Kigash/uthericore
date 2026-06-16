table 50112 "Security Register"
{
    // version TL2.0

    DataCaptionFields = Description;
    DrillDownPageID = 51330;
    LookupPageID = 51330;

    fields
    {
        field(1; Code; Code[250])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; "Security Type Code"; Code[30])
        {
            TableRelation = "Security Type";
        }
    }

    keys
    {
        key(Key1; Code)
        {
        }
    }

    fieldgroups
    {
    }
}

