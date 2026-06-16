page 50031 "Cheque Types"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Cheque Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Clearing Days"; Rec."Clearing Days")
                {
                    ApplicationArea = All;
                }
                field(CDays; Rec.CDays)
                {
                    Visible = false;
                }
                field("Clearing Charges"; Rec."Clearing Charges")
                {
                    ApplicationArea = All;
                }
                field("Clearing Charges GL Account"; Rec."Clearing Charges GL Account")
                {
                    ApplicationArea = All;
                }
                field("Clearing Bank Account"; Rec."Clearing Bank Account")
                {
                    Visible = false;
                }
                field("Special Clearing Days"; Rec."Special Clearing Days")
                {
                    Visible = false;
                }
                field("Special Clearing Charges"; Rec."Special Clearing Charges")
                {
                    ApplicationArea = All;
                }
                field("Bounced Cheque Charges"; Rec."Bounced Cheque Charges")
                {
                    ApplicationArea = All;
                }
                field("Bounced Cheque GL Account"; Rec."Bounced Cheque GL Account")
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

