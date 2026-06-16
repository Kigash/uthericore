page 50007 "SmartTeller No Series"
{
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Smart Teller No Series";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Deposit; Rec.Deposit)
                {
                    ApplicationArea = All;
                }
                field(Withdrawal; Rec.Withdrawal)
                {
                    ApplicationArea = All;
                }
                field("Cheque Deposit"; Rec."Cheque Deposit")
                {
                    ApplicationArea = All;
                }
                field("Request From Treasury"; Rec."Request From Treasury")
                {
                    ApplicationArea = All;
                }
                field("Return To Treasury"; Rec."Return To Treasury")
                {
                    ApplicationArea = All;
                }
                field("Inter Teller"; Rec."Inter Teller")
                {
                    ApplicationArea = All;
                }
                field(InterAccount; Rec.InterAccount)
                {
                    ApplicationArea = All;
                }
                field("Receive From Bank"; Rec."Receive From Bank")
                {
                    ApplicationArea = All;
                }
                field("Return To Bank"; Rec."Return To Bank")
                {
                    ApplicationArea = All;
                }
                field("ATM Request"; Rec."ATM Request")
                {
                    ApplicationArea = All;
                }
                field(Imprest; Rec.Imprest)
                {
                    ApplicationArea = All;
                }
                field(MemberApplication; Rec.MemberApplication)
                {
                    ApplicationArea = All;
                }
                field("Issue To Teller"; Rec."Issue To Teller")
                {
                    ApplicationArea = All;
                }
                field("Spotcash Request"; Rec."Spotcash Request")
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

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}