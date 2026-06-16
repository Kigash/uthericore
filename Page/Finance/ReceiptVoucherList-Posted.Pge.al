page 50628 "Receipt Voucher List-Posted"
{
    // version TL2.0
    Caption = 'Posted Receipt Vouchers';
    CardPageID = "Receipt Voucher";
    PageType = List;
    SourceTable = "Receipt Header";
    SourceTableView = WHERE(Status = FILTER(New),
                            Posted = filter(true));
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

