page 56607 "Board PaymentV List-Posted"
{
    // version TL2.0

    CardPageID = "Board Payment Voucher";
    DataCaptionFields = "No.";
    PageType = List;
    SourceTable = "Board Payment Header";
    SourceTableView = WHERE(Status = filter(Approved),
                            Posted = filter(true));
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
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
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
                field("Total Tax Amount"; Rec."Total Tax Amount")
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
                field("Approved By"; Rec."Approved By")
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

