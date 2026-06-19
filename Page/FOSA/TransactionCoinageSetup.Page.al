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
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Coinage Code" <> '' then
                            Rec.Validate("Coinage Code");

                        CurrPage.Update();
                    end;

                }
                field("Coinage Code"; Rec."Coinage Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
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