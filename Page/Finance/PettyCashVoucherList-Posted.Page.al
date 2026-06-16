page 50640 "PettyCash V. List-Posted"
{
    // version TL2.0

    CardPageID = "PettyCash Voucher";
    PageType = List;
    SourceTable = "PettyCash Header";
    SourceTableView = where(Status = filter(Approved), Posted = filter(true));
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
                field("Payee Name"; Rec."Payee Name")
                {
                    ApplicationArea = All;
                }

                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Total Line Amount"; Rec."Total Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("Total W/Tax Amount"; Rec."Total W/Tax Amount")
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
                field("Posted By"; Rec."Posted By")
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

