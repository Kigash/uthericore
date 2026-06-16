page 50707 "Procurement Methods"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Procurement Method";

    layout
    {
        area(content)
        {
            Group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Method; Rec.Method)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Document Open Period"; Rec."Document Open Period")
                {
                    ApplicationArea = All;
                }
                field("Process Evaluation Period"; Rec."Process Evaluation Period")
                {
                    ApplicationArea = All;
                }
                field("Award Approval"; Rec."Award Approval")
                {
                    ApplicationArea = All;
                }
                field("Notification Of Award"; Rec."Notification Of Award")
                {
                    ApplicationArea = All;
                }
                field("Contract Signing"; Rec."Contract Signing")
                {
                    ApplicationArea = All;
                }
                field("Closing Period"; Rec."Closing Period")
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

