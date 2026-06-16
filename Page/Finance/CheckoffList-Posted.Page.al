page 50663 "Checkoff List-Posted"
{
    // version TL2.0
    Caption = 'Posted Checkoffs';
    CardPageID = Checkoff;
    PageType = List;
    SourceTable = "Checkoff Header";
    SourceTableView = WHERE(Status = FILTER(New),
                            Posted = filter(true), Reversed = filter(false));
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }
                field("Posted Date"; Rec."Posted Date")
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

