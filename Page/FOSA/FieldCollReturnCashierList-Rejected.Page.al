page 57098 "FieldColl RetuCashier-Rejected"
{
    Caption = 'Field Coll Return To Cashier Rejected';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Field Coll Return To Chashier";
    CardPageId = "Field Coll Return Cashier Card";
    SourceTableView = where(Status = filter(Rejected), Posted = filter(false));
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(TellerReturnTreasury)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;

                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;

                }
                field("Field Officer User ID"; Rec."Field Officer User ID")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}