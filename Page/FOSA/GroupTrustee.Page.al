page 50059 "Group Trustee"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Beneficiary Type";
    SourceTableView = WHERE(Type = CONST("Group Trustee"));
    AutoSplitKey = true;

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

                field("Allocation (%)"; Rec."Allocation (%)")
                {
                    ApplicationArea = All;
                }
                field("Witness Name"; Rec."Witness Name")
                {
                    ApplicationArea = All;
                }
                field("Witness National ID"; Rec."Witness National ID")
                {
                    ApplicationArea = All;
                }
                field("Witness Mobile No."; Rec."Witness Mobile No.")
                {
                    ApplicationArea = All;
                }
                field("Witness Postal Address"; Rec."Witness Postal Address")
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
}

