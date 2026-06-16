page 50607 "Payment Voucher List-Posted"
{
    // version TL2.0

    CardPageID = "Payment Voucher Posted";
    DataCaptionFields = "No.";
    PageType = List;
    SourceTable = "Payment Header";
    SourceTableView = WHERE(Posted = filter(true));
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field("Payment Mode"; Rec."Payment Method")
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

