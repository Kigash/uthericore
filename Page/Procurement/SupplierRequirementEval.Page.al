page 50765 "Supplier Requirement Eval"
{
    PageType = List;
    SourceTable = "Supplier Evaluation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Evaluation Stage"; Rec."Evaluation Stage")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Evaluation Code"; Rec."Evaluation Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Evaluation Description"; Rec."Evaluation Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Needs Attachment"; Rec."Needs Attachment")
                {
                    ApplicationArea = All;
                }
                field("Document Attached"; Rec."Document Attached")
                {
                    ApplicationArea = All;
                }
                field("Score(%)"; Rec."Score(%)")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Evaluating UserID"; Rec."Evaluating UserID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Average Score")
            {
                ApplicationArea = All;
                Image = ActivateDiscounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction();
                begin
                    /*SupplierEvaluation.COPYFILTERS(Rec);
                    ProcurementManagement.GenerateAverageScore(SupplierEvaluation,1);
                    CurrPage.CLOSE;
                    */

                end;
            }
        }
    }

    var
        SupplierEvaluation: Record "Supplier Evaluation";
        ProcurementManagement: Codeunit "Procurement Management";
}

