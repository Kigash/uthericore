page 50069 "Transaction Coinage Setup"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Transaction Coinage Setup";
    Caption = 'Transaction Coinage Setup';
    layout
    {
        area(Content)
        {
            repeater(TransactionCoinage)
            {
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                }
                field("Coinage Code"; Rec."Coinage Code")
                {
                    ApplicationArea = All;

                }
                field("Coinage Value"; Rec."Coinage Value")
                {
                    ApplicationArea = All;

                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;

                }
            }
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