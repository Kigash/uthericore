page 50440 "Human Resource Doc"
{
    Caption = 'Attached Documents';
    DelayedInsert = true;
    Editable = true;
    PageType = Worksheet;
    SourceTable = "Human Resource Document";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the filename of the attachment.';

                    trigger OnDrillDown()
                    var
                        TempBlob: Codeunit "Temp Blob";
                        FileManagement: Codeunit "File Management";
                        FileName: Text;
                    begin
                        if Rec."Document Reference ID".HasValue then
                            Rec.Export(true)
                        else begin
                            //FileName := FileManagement.BLOBImportWithFilter(
                            //TempBlob, ImportTxt, FileName, StrSubstNo(FileDialogTxt, FilterTxt), FilterTxt);
                            if FileName <> '' then
                                Rec.SaveAttachment(FromRecRef, FileName, TempBlob);
                            CurrPage.Update(false);
                        end;
                    end;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the file extension of the attachment.';
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the type of document that the attachment is.';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the user who attached the document.';
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the document was attached.';
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Preview)
            {
                ApplicationArea = All;
                Caption = 'Preview';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Get a preview of the attachment.';

                trigger OnAction()
                begin
                    if Rec."File Name" <> '' then
                        Rec.Export(true);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        FlowFieldsEditable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."File Name" := SelectFileTxt;
    end;

    var
        FromRecRef: RecordRef;
        SalesDocumentFlow: Boolean;
        FileDialogTxt: Label 'Attachments (%1)|%1', Comment = '%1=file types, such as *.txt or *.docx';
        FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*', Locked = true;
        ImportTxt: Label 'Attach a document.';
        SelectFileTxt: Label 'Select File...';
        PurchaseDocumentFlow: Boolean;
        FlowToPurchTxt: Label 'Flow to Purch. Trx';
        FlowToSalesTxt: Label 'Flow to Sales Trx';
        FlowFieldsEditable: Boolean;

    local procedure GetCaptionClass(FieldNo: Integer): Text
    begin
        if SalesDocumentFlow and PurchaseDocumentFlow then
            case FieldNo of
                9:
                    exit(FlowToPurchTxt);
                11:
                    exit(FlowToSalesTxt);
            end;
    end;

    procedure OpenForRecRef(RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        LineNo: Integer;
    begin
        Rec.RESET;

        FromRecRef := RecRef;

        Rec.SETRange("Table ID", RecRef.Number);

        if RecRef.Number = DATABASE::Item then begin
            SalesDocumentFlow := true;
            PurchaseDocumentFlow := true;
        end;

        case RecRef.Number of
            DATABASE::"Sales Line",
            DATABASE::"Purchase Line":
                begin
                    FieldRef := RecRef.field(4);
                    LineNo := FieldRef.Value;
                    Rec.SETRange("Line No.", LineNo);
                end;
        end;



        OnAfterOpenForRecRef(Rec, RecRef);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Human Resource Document"; var RecRef: RecordRef)
    begin
    end;
}
