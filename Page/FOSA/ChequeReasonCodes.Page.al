page 50167 "Cheq. Reason Codes"
{
    // version TL2.0

    Caption = 'Cheque Reason Codes';
    PageType = List;
    SourceTable = "CC Reason Code";

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
                field("Charge Amount"; Rec."Charge Amount")
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

