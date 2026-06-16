table 54609 "Bulk SMS Line"
{

    fields
    {
        field(1;"Document No";Code[10])
        {
        }
        field(2;"Line No";Integer)
        {
        }
        field(3;"Vehicle No Plate";Code[10])
        {
        }
        field(4;"Owner Member No";Code[10])
        {
        }
        field(5;"Owner Name";Text[150])
        {
        }
        field(6;"Owner Phone No";Code[15])
        {
        }
        field(7;Select;Boolean)
        {
        }
        field(8;"Sent To Phone No";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Line No","Document No")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(dropdown;"Owner Member No","Owner Name")
        {
        }
    }
}

