page 51014 "Driver Setup List"
{
    // version TL2.0

    CardPageID = "Driver Setup Card";
    PageType = List;
    SourceTable = "Driver Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Full Names"; Rec."Full Names")
                {
                    ApplicationArea = All;
                }
                field("ID NO."; Rec."ID NO.")
                {
                    ApplicationArea = All;
                }
                field("Driving License"; Rec."Driving License")
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

