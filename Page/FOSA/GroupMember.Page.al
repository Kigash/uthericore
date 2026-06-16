page 50057 "Group Member"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Beneficiary Type";
    SourceTableView = WHERE(Type = CONST("Group Member"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
    }

    var
        Ben: Record "Beneficiary Type";
}

